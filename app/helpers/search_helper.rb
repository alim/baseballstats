module SearchHelper
  
  # Returns an array that can be used in the select tag helper
  def year_list
  
    years = []
    start_year = Date.today.year
    
    # Build year list
    200.times.each do |year|
      current_year = start_year - year
      years << ["#{current_year}", current_year]
    end
      
    return options_for_select(years)
  end
  
  # Returns an array of teams from the batting statistics data in
  # a format that can be used by the select tag helper
  def team_list
    teams = BattingStatistic.all.pluck(:team)
    teams = teams.uniq!
    
    team_array = []
    if teams.present?
      teams.each do | team |
        team_array << [team, team]
      end
    end
    team_array.sort!
    return options_for_select(team_array)
  end
  
  # Returns a string that holds the players first and last name or 
  # 'No player name found', if we cannot find the player record.
  def player_name(player_id)
    player = Player.where(player_id: player_id).first
    
    if player.present?
      str = "#{player.first_name} #{player.last_name}"
    else
      str = 'No player name found'
    end
    
    return str
  end
end
