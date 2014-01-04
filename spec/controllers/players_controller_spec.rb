require 'spec_helper'

describe PlayersController do

  let(:valid_attributes) { { 
    player_id: "allenje01",
    birth_year: 1972,
    first_name: "Jermaine",
    last_name: "Allensworth II",
  } }

  before(:each){
    50.times.each { FactoryGirl.create(:player) }
    @player = Player.last
  }

  
  describe "GET index" do
    it "assigns all players as @players" do
      get :index
      assigns(:players).count.should eq(ApplicationController::PAGE_COUNT)
    end
  end

  describe "GET show" do
    it "assigns the requested player as @player" do
      get :show, {id: @player.to_param}
      assigns(:player).should eq(@player)
    end
  end

  describe "GET new" do
    it "assigns a new player as @player" do
      get :new
      assigns(:player).should be_a_new(Player)
    end
  end

  describe "GET edit" do
    it "assigns the requested player as @player" do
      get :edit, {id: @player.to_param}
      assigns(:player).should eq(@player)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Player" do
        expect {
          post :create, {player: valid_attributes}
        }.to change(Player, :count).by(1)
      end

      it "assigns a newly created player as @player" do
        post :create, {player: valid_attributes}
        assigns(:player).should be_a(Player)
        assigns(:player).should be_persisted
      end

      it "redirects to the created player" do
        post :create, {player: valid_attributes}
        response.should redirect_to(assigns(:player))
      end
    end

    describe "with invalid params" do
      before(:each) {
        @invalid_params = valid_attributes
        @invalid_params[:birth_year] = 1492 
      }
    
      it "assigns a newly created but unsaved player as @player" do
        Player.any_instance.stub(:save).and_return(false)
        post :create, {player: @invalid_params}
        assigns(:player).should be_a_new(Player)
      end

      it "re-renders the 'new' template" do 
        # Example without stub
        post :create, {player: @invalid_params}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested player" do
        put :update, {id: @player.to_param, player: valid_attributes}
        assigns(:player).last_name.should eq(valid_attributes[:last_name])
      end

      it "assigns the requested player as @player" do
        put :update, {id: @player.to_param, player: valid_attributes}
        assigns(:player).should eq(@player)
      end

      it "redirects to the player" do
        put :update, {id: @player.to_param, player: valid_attributes}
        response.should redirect_to(@player)
      end
    end

    describe "with invalid params" do
      before(:each) {
        @invalid_params = valid_attributes
        @invalid_params[:birth_year] = 'abcd' 
      }
          
      it "assigns the player as @player" do
        Player.any_instance.stub(:save).and_return(false)
        put :update, {id: @player.to_param, player: @invalid_params}
        assigns(:player).should eq(@player)
      end

      it "re-renders the 'edit' template" do
        put :update, {id: @player.to_param, player: @invalid_params}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested player" do
      expect {
        delete :destroy, {id: @player.to_param}
      }.to change(Player, :count).by(-1)
    end

    it "redirects to the players list" do
      delete :destroy, {id: @player.to_param}
      response.should redirect_to(players_url)
    end
  end

end
