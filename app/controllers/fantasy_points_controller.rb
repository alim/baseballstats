########################################################################
# The FantasyPointsController is responsible for managing the 
# FantasyPoint model and view interaction. This resource allows the
# user to change the point assignments for different baseball 
# statistics that are used in a fantasy baseball league. The list 
# of available fantasy baseball statistics is shown in the FantasyPoint
# model. The controller helps to enforce the Singleton design pattern
# that is put in place by the FantasyPoint model validation.
########################################################################
class FantasyPointsController < ApplicationController

  ## CALLBACKS ---------------------------------------------------------
  
  before_action :set_fantasy_point, only: [:show, :edit, :update, :destroy]
  before_action :set_fantasy_menu_active
  
  ######################################################################
  # GET /fantasy_points
  # GET /fantasy_points.json
  #
  # The index method will redirect to a different action depending
  # on the current state of the FantasyPoint model. The redirection 
  # will be as follows:
  #
  # * If a FantasyPoint model instance already exists, the user will be redirected to the show action
  # * If a FantasyPoint model does not exist, the user will be redirected to the new action
  ######################################################################
  def index
    if FantasyPoint.count > 0
      @fantasy_point = FantasyPoint.first
      redirect_to @fantasy_point
    else
      redirect_to new_fantasy_point_url
    end
  end

  ######################################################################
  # GET /fantasy_points/1
  # GET /fantasy_points/1.json
  #
  # The method will display the current FantasyPoint attributes and
  # their point assignments.
  ######################################################################
  def show
  end

  ######################################################################
  # GET /fantasy_points/new
  #
  # The new method presents a new FantasyPoint form for assigning
  # fantasy point values to available statistics.
  ######################################################################
  def new
    @fantasy_point = FantasyPoint.new
  end

  ######################################################################
  # GET /fantasy_points/1/edit
  #
  # The edit method retrieves the current FantasyPoint model and 
  # displays the current values to the user for updating.
  ######################################################################
  def edit
  end

  ######################################################################
  # POST /fantasy_points
  # POST /fantasy_points.json
  #
  # The create method creates a new FantasyPoint model, if one does not
  # yet exist. It relies on the FantasyPoint model to enforce the 
  # Singleton design pattern.
  ######################################################################
  def create
    @fantasy_point = FantasyPoint.new(fantasy_point_params)

    respond_to do |format|
      if @fantasy_point.save
        format.html { redirect_to @fantasy_point, notice: 'Fantasy point was successfully created.' }
        format.json { render action: 'show', status: :created, location: @fantasy_point }
      else
        @verrors = @fantasy_point.errors.full_messages
        format.html { render action: 'new' }
        format.json { render json: @fantasy_point.errors, status: :unprocessable_entity }
      end
    end
  end

  ######################################################################
  # PATCH/PUT /fantasy_points/1
  # PATCH/PUT /fantasy_points/1.json
  #
  # The update method will update the FantasyPoint attribute point
  # values of an existing FantasyPoint model object.
  ######################################################################
  def update
    respond_to do |format|
      if @fantasy_point.update(fantasy_point_params)
        format.html { redirect_to @fantasy_point, notice: 'Fantasy point was successfully updated.' }
        format.json { head :no_content }
      else
        @verrors = @fantasy_point.errors.full_messages
        format.html { render action: 'edit' }
        format.json { render json: @fantasy_point.errors, status: :unprocessable_entity }
      end
    end
  end

  ######################################################################
  # DELETE /fantasy_points/1
  # DELETE /fantasy_points/1.json
  #
  # The destroy method is a standard controller method to destroy the
  # existing FantasyPoint model object.
  ######################################################################
  def destroy
    @fantasy_point.destroy
    respond_to do |format|
      format.html { redirect_to fantasy_points_url }
      format.json { head :no_content }
    end
  end

  ## PRIVATE INSTANCE METHODS ------------------------------------------
  
  private
  
    ####################################################################
    # Use callbacks to share common setup or constraints between actions.
    ####################################################################
    def set_fantasy_point
      @fantasy_point = FantasyPoint.find(params[:id])
    end

    ####################################################################
    # Callback to set the Fantasy menu to active state
    ####################################################################
    def set_fantasy_menu_active
      @fantasy_menu_active = 'class=active'
    end
    
    ####################################################################
    # Never trust parameters from the scary internet, only allow the 
    # white list through.
    ####################################################################
    def fantasy_point_params
      params.require(:fantasy_point).permit(:home_run, :rbi, 
        :stolen_base, :caught_stealing)
    end
end
