########################################################################
# The BattingStatisticsController is responsible for managing the
# interaction and updating of BattingStatistic records. It has all the
# standard CRUD actions plus an action that supports uploading and
# replacing the system's batting statistics from a CSV file.
########################################################################
class BattingStatisticsController < ApplicationController

  ## CALLBACK DEFINITIONS ----------------------------------------------

  before_action :set_batting_statistic, only: [:show, :edit, :update, :destroy]
  before_action :set_batting_menu_active

  ######################################################################
  # GET /batting_statistics
  # GET /batting_statistics.json
  #
  # The index action method allows displaying all the currently loaded
  # batting statistics. It paginates them for easier access and shorter
  # load times. The view also includes an embedded form to enable
  # uploading of a new batting statistics file.
  ######################################################################
  def index
    # Get page number from paginate plugin used in view
    page = params[:page].nil? ? 1 : params[:page]
    
    @batting_statistics = BattingStatistic.order_by([[ :player_id, :asc ]]).paginate(
        page: page, per_page: PAGE_COUNT) # PAGE_COUNT is from parent
  end

  ######################################################################
  # GET /batting_statistics/1
  # GET /batting_statistics/1.json
  #
  # The show method displays an individual batting statistics record.
  # It also displays the caculated statistics of batting average and 
  # slugging percentage.
  ######################################################################
  def show
  end

  ######################################################################
  # GET /batting_statistics/new
  # 
  # Displays a new batting statistics form.
  ######################################################################
  def new
    @batting_statistic = BattingStatistic.new
  end

  ######################################################################
  # GET /batting_statistics/1/edit
  #
  # Displays an edit form for editing an existing batting statistics
  # record.
  ######################################################################
  def edit
  end

  ######################################################################
  # POST /batting_statistics
  # POST /batting_statistics.json
  #
  # Creates a new batting statistics record.  
  ######################################################################
  def create
    @batting_statistic = BattingStatistic.new(batting_statistic_params)

    respond_to do |format|
      if @batting_statistic.save
        format.html { redirect_to @batting_statistic, notice: 'Batting statistic was successfully created.' }
        format.json { render action: 'show', status: :created, location: @batting_statistic }
      else
        format.html { render action: 'new' }
        format.json { render json: @batting_statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  ######################################################################
  # PATCH/PUT /batting_statistics/1
  # PATCH/PUT /batting_statistics/1.json
  #
  # Updates an existing batting statistics record.
  ######################################################################
  def update
    respond_to do |format|
      if @batting_statistic.update(batting_statistic_params)
        format.html { redirect_to @batting_statistic, notice: 'Batting statistic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @batting_statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  ######################################################################
  # DELETE /batting_statistics/1
  # DELETE /batting_statistics/1.json
  #
  # Destroys the requested batting statistics record
  ######################################################################
  def destroy
    @batting_statistic.destroy
    respond_to do |format|
      format.html { redirect_to batting_statistics_url }
      format.json { head :no_content }
    end
  end
  
  ######################################################################
  # POST /batting_statistics/import
  #
  # The import method allows uploading of a CSV file with batting 
  # statistics. It uses the BattingStatistic model import class method
  # for uploading the batting statistics.
  ######################################################################
  def import
    BattingStatistic.import(params[:file])
    message = "Battings statistics imported: #{BattingStatistic.count} successful and #{BattingStatistic.skipped} skipped."
    redirect_to batting_statistics_url, notice: message 
  end

  private
    ####################################################################
    # Use callbacks to share common setup or constraints between actions.
    ####################################################################
    def set_batting_statistic
      @batting_statistic = BattingStatistic.find(params[:id])
    end

    ####################################################################
    # Callback to set the Batting Stats menu to active state
    ####################################################################
    def set_batting_menu_active
      @batting_menu_active = 'class=active'    
    end

    ####################################################################
    # Never trust parameters from the scary internet, only allow the white list through.
    ####################################################################
    def batting_statistic_params
      params.require(:batting_statistic).permit(:player_id, :year, :team, :games_played, :at_bats, :runs_scored, :hits, :doubles, :triples, :home_runs, :runs_batted_in, :stolen_bases, :caught_stealing)
    end
end
