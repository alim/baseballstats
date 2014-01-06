########################################################################
# The SearchController is responsible for handling search requests 
# against the batting statistics data and the fantasy point settings.
# Each search is implemented with a separate action. If we were to
# scale this controller, I would suggest using a design pattern based
# on the "Strategy" approach or something similar.
########################################################################
class SearchController < ApplicationController

  ######################################################################
  # The index method presents a set of predefined search tabs based
  # on the current set of requirements.
  ######################################################################
  def index
    if params[:tab].present?
      case params[:tab]
      when 'tab1'
        @tab1 = 'class=active'
      when 'tab2'
        @tab2 = 'class=active'
      when 'tab3'
        @tab3 = 'class=active'
      when 'tab4'
        @tab4 = 'class=active'
      else
        @tab1 = 'class=active'
      end
    else
      @tab1 = 'class=active'
    end
  end

  ######################################################################
  # POST /improved
  #
  # The improved action calculates the most improved player for a given
  # time period and with a minium number of at bats. The parameters
  # that it expects are:
  #
  # * start_year
  # * end_year
  # * min_at_bats
  #
  # The end year must be greater than or equal to the start year and
  # the min_at_bats must be greater than 0.
  ######################################################################
  def improved
    @start_year = params[:start_year]
    @end_year = params[:end_year]
    @min_at_bats = params[:min_at_bats]
    
    if @end_year >= @start_year
      startstats = BattingStatistic.by_year(@start_year, @min_at_bats)
      endstats = BattingStatistic.by_year(@end_year, @min_at_bats)

      # Build hash of improvement scores - hash includes
      # player_id, improvement score. This is a brute force search,
      # we could implement something better later.
      improvements = {}
      last_stat = endstats.first
      
      endstats.each do |endstat|
        startstat = startstats.where(player_id: endstat.player_id).order_by([[:batting_average, :asc]]).first
        if startstat.present?
        
          # Check to see if we have multiple enteries for a player in 
          # the ending year. If we do use the best batting average
          if last_stat.player_id > endstat.player_id
            best_stat = last_stat             
          else
            best_stat = endstat
          end
          
          # Insert the improvment score into the hash using player_id as 
          # the key for the hash.
          improvements["#{endstat.player_id}"] = best_stat.batting_average - startstat.batting_average
        end
        
        last_stat = endstat
      end
      
      # Sort the improvement hash and label the winner
      improvements = improvements.sort_by {|k,v| v}.reverse
      @winner = improvements[0]
      @player = Player.where(player_id: @winner[0]).first
      
    else
      flash[:alert] = "End year must be greater than or equal to start year."
      redirect_to search_index_path(tab: 'tab1')
    end 
  end

  ######################################################################
  # The slugging action allows the user to submit a slugging percentage
  # search for a given year and team.
  ######################################################################
  def slugging
    @year = params[:year]
    @team = params[:team]
    
    if @year.present? && @team.present?
      @stats = BattingStatistic.team_slugging(@year, @team)
    else
      flash[:alert] = "You need to specify both a team and a year."
      redirect_to search_index_path(tab: 'tab2')
    end
  end

  ######################################################################
  # The fantasy_improved method will calculate the total fantasy points
  # for each player between two years. It will then collect the top
  # 5 results for display.
  ######################################################################
  def fantasy_improved
    @start_year = params[:start_year]
    @end_year = params[:end_year]
    @min_at_bats = params[:min_at_bats]

    if @end_year >= @start_year
      startstats = BattingStatistic.by_year(@start_year, @min_at_bats)
      start_points = fantasy_points(startstats)
      
      endstats = BattingStatistic.by_year(@end_year, @min_at_bats)
      end_points = fantasy_points(endstats)

      # Build hash of improvement scores - hash includes
      # player_id, improvement score. This is a brute force search,
      # we could implement something better later.
      @improvements = {}     
      
      end_points.each do |player, points|
        if start_points[player].present?
          @improvements[player] = points - start_points[player]
        end
      end

      # Sort the improvement hash and label the winner
      @improvements = @improvements.sort_by {|k,v| v}.reverse
puts "\n\n[fantasy_improved] improvments after sort = #{@improvements}\n\n"      
      
puts "[fantasy_improved] start = #{start_points} \n\n end = #{end_points}"
      @results = @improvements[0..4]
      
puts "[fantasy_improved] results = #{@results} \n\n"

    else
      flash[:alert] = "End year must be greater than or equal to start year."
      redirect_to search_index_path(tab: 'tab3')
    end
  end

  ######################################################################
  # The triple_crown method allows a search for a triple crown winner
  # for any given year. If it does not find a winner, the view will
  # display the closest results.
  ######################################################################
  def triple_crown
    @year = params[:year]
    stats = BattingStatistic.where(year: @year, :home_runs.gt => 0, :runs_batted_in.gt => 0)
    
    @ba_list = stats.where(batting_average: stats.max(:batting_average))
    @rbi_list = stats.where(runs_batted_in: stats.max(:runs_batted_in))
    @hr_list = stats.where(home_runs: stats.max(:home_runs))
    
    # Go throught home run list and check to see if any players are on
    # the other two lists.
    tc_winner = []
    
    @hr_list.each do |hrstat|
      bastat = @ba_list.where(player_id: hrstat.player_id).first
      rbistat = @rbi_list.where(player_id: hrstat.player_id).first
      
      # Check to see if we have a winner
      if bastat.present? and rbistat.present?
        tc_winner << hrstat.player_id
      end
    end
    
    @player = tc_winner.present? ? Player.where(player_id: tc_winner[0]).first : nil
    
  end
  
  
  ## Private Helper methods --------------------------------------------
  
  private
  
  ######################################################################
  # The fantasy_points method takes a list of batting statistics
  # and returns a hash with the player_id as the key and the fantasy
  # points as the value.
  ######################################################################
  def fantasy_points(stats)
    points = {}
    fan_points = FantasyPoint.first
    
    if fan_points.present?
      stats.each do |stat|
        hr_points = stat.home_runs * fan_points.home_run
        rbi_points = stat.runs_batted_in * fan_points.rbi
        base_points = stat.stolen_bases * fan_points.stolen_base
        stealing_points = stat.caught_stealing * fan_points.caught_stealing
        
        if points["#{stat.player_id}"].present?
          points["#{stat.player_id}"] = points["#{stat.player_id}"] + hr_points + rbi_points + base_points + stealing_points
        else
          points["#{stat.player_id}"] = hr_points + rbi_points + base_points + stealing_points        
        end
      end
    end
    
    return points
  end
   
end
