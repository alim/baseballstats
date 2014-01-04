########################################################################
# The PlayersController is responsible for managing the
# interaction and updating of Player records. It has all the
# standard CRUD actions plus an action that supports uploading and
# replacing the system's player records from a CSV file.
########################################################################
class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :set_players_menu_active
  
  ######################################################################
  # GET /players
  # GET /players.json
  #
  # Shows all players sorted by player ID and paginated.
  ######################################################################
  def index
    # Get page number from paginate plugin used in view
    page = params[:page].nil? ? 1 : params[:page]
  
    @players = Player.order_by([[ :player_id, :asc ]]).paginate(page: page, per_page: PAGE_COUNT)
  end

  ######################################################################
  # GET /players/1
  # GET /players/1.json
  # 
  # Shows an individual player record.
  ######################################################################
  def show
  end

  ######################################################################
  # GET /players/new
  #
  # Generates a new player record form.
  ######################################################################
  def new
    @player = Player.new
  end

  ######################################################################
  # GET /players/1/edit
  #
  # Generates an edit form for the requested player record.
  ######################################################################
  def edit
  end

  ######################################################################
  # POST /players
  # POST /players.json
  #
  # Creates a new player record.
  ######################################################################
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render action: 'show', status: :created, location: @player }
      else
        format.html { render action: 'new' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  ######################################################################
  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  #
  # Updates an existing player record.
  ######################################################################
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  ######################################################################
  # DELETE /players/1
  # DELETE /players/1.json
  #
  # Destroys the requested player record.
  ######################################################################
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end

  ######################################################################
  # POST /players/import
  #
  # The import method allows uploading of a CSV file with batting 
  # statistics. It uses the Player model import class method
  # for uploading the batting statistics.
  ######################################################################
  def import
    Player.import(params[:file])
    message = "Players imported: #{Player.count} successful and #{Player.skipped} skipped."
    redirect_to players_url, notice: message 
  end

  ## PRIVATE INSTANCE METHODS ------------------------------------------

  private
    ####################################################################  
    # Use callbacks to share common setup or constraints between actions.
    ####################################################################
    def set_player
      @player = Player.find(params[:id])
    end

    ####################################################################
    # Callback to set the Batting Stats menu to active state
    ####################################################################
    def set_players_menu_active
      @players_menu_active = 'class=active'    
    end

    ####################################################################
    # Never trust parameters from the scary internet, only allow the white list through.
    ####################################################################
    def player_params
      params.require(:player).permit(:player_id, :birth_year, :first_name, :last_name)
    end
end
