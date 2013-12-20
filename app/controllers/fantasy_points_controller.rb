class FantasyPointsController < ApplicationController
  before_action :set_fantasy_point, only: [:show, :edit, :update, :destroy]
  before_action :set_fantasy_menu_active
  
  # GET /fantasy_points
  # GET /fantasy_points.json
  def index
    @fantasy_points = FantasyPoint.all
  end

  # GET /fantasy_points/1
  # GET /fantasy_points/1.json
  def show
  end

  # GET /fantasy_points/new
  def new
    @fantasy_point = FantasyPoint.new
  end

  # GET /fantasy_points/1/edit
  def edit
  end

  # POST /fantasy_points
  # POST /fantasy_points.json
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

  # PATCH/PUT /fantasy_points/1
  # PATCH/PUT /fantasy_points/1.json
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

  # DELETE /fantasy_points/1
  # DELETE /fantasy_points/1.json
  def destroy
    @fantasy_point.destroy
    respond_to do |format|
      format.html { redirect_to fantasy_points_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fantasy_point
      @fantasy_point = FantasyPoint.find(params[:id])
    end

    # Callback to set the Fantasy menu to active state
    def set_fantasy_menu_active
      @fantasy_menu_active = 'class=active'
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def fantasy_point_params
      params.require(:fantasy_point).permit(:home_run, :rbi, :stolen_base, :caught_stealing)
    end
end
