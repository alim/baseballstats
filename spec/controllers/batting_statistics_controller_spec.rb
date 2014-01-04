require 'spec_helper'


describe BattingStatisticsController do

  let(:valid_attributes) { { 
    player_id: 'splayer01',
    year: '1954',
    team: "DET",
    games_played: 610,
    at_bats: 1000,
    runs_scored:  510,
    hits: 759,
    doubles: 125,
    triples: 89,
    home_runs: 34,
    runs_batted_in: 613,
    stolen_bases: 124,
    caught_stealing: 21,
  } }

  before(:each){
    25.times.each { FactoryGirl.create(:batting_statistic) }
    @stat = BattingStatistic.where(:batting_average.gt => 0).first
  }

  describe "GET index" do
    it "assigns batting_statistics as @batting_statistics" do
      get :index
      assigns(:batting_statistics).count.should eq(ApplicationController::PAGE_COUNT)
    end
  end

  describe "GET show" do
    it "assigns the requested batting_statistic as @batting_statistic" do
      get :show, {id: @stat.to_param}
      assigns(:batting_statistic).should eq(@stat)
    end
    
    it "should show the calculated batting average" do
      get :show, {id: @stat.to_param}
      assigns(:batting_statistic).batting_average.should > 0
      ba = @stat.hits / @stat.at_bats.to_f
      assigns(:batting_statistic).batting_average.should eq(ba)
    end
    
    it "should show the calculated slugging percentage" do
      stat = BattingStatistic.where(:slugging_percent.gt => 0).first
      get :show, {id: stat.to_param}
      assigns(:batting_statistic).slugging_percent.should > 0
      assigns(:batting_statistic).slugging_percent.should eq(stat.slugging_percent)
    end    
  end

  describe "GET new" do
    it "assigns a new batting_statistic as @batting_statistic" do
      get :new
      assigns(:batting_statistic).should be_a_new(BattingStatistic)
    end
  end

  describe "GET edit" do
    it "assigns the requested batting_statistic as @batting_statistic" do
      get :edit, {id: @stat.to_param}
      assigns(:batting_statistic).should eq(@stat)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new BattingStatistic" do
        expect {
          post :create, {:batting_statistic => valid_attributes}
        }.to change(BattingStatistic, :count).by(1)
      end

      it "assigns a newly created batting_statistic as @batting_statistic" do
        post :create, {:batting_statistic => valid_attributes}
        assigns(:batting_statistic).should be_a(BattingStatistic)
        assigns(:batting_statistic).should be_persisted
      end

      it "redirects to the created batting_statistic" do
        post :create, {:batting_statistic => valid_attributes}
        response.should redirect_to(assigns(:batting_statistic))
      end
    end

    describe "with invalid params" do
      before(:each) {
        @invalid_params = valid_attributes
        @invalid_params[:at_bats] = -98
      }
      
      it "assigns a newly created but unsaved batting_statistic as @batting_statistic" do
        # Example using a stub
        BattingStatistic.any_instance.stub(:save).and_return(false)
        post :create, {:batting_statistic => { "player_id" => "invalid value" }}
        assigns(:batting_statistic).should be_a_new(BattingStatistic)
      end

      it "re-renders the 'new' template" do
        # Example using invalid parameters
        post :create, {batting_statistic: @invalid_params}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested batting_statistic" do
        put :update, {id: @stat.to_param, batting_statistic: valid_attributes}
      end

      it "assigns the requested batting_statistic as @batting_statistic" do
        put :update, {id: @stat.to_param, batting_statistic: valid_attributes}
        assigns(:batting_statistic).should eq(@stat)
      end

      it "redirects to the batting_statistic" do
        put :update, {id: @stat.to_param, batting_statistic: valid_attributes}
        response.should redirect_to(@stat)
      end
    end

    describe "with invalid params" do
      before(:each) {
        @invalid_params = valid_attributes
        @invalid_params[:hits] = -153
      }    
    
      it "assigns the batting_statistic as @batting_statistic" do

        # Example with stub
        BattingStatistic.any_instance.stub(:save).and_return(false)
        put :update, {id: @stat.to_param, batting_statistic: @invalid_params}
        assigns(:batting_statistic).should eq(@stat)
      end

      it "re-renders the 'edit' template" do
        put :update, {id: @stat.to_param, batting_statistic: @invalid_params}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested batting_statistic" do
      expect {
        delete :destroy, {id: @stat.to_param}
      }.to change(BattingStatistic, :count).by(-1)
    end

    it "redirects to the batting_statistics list" do
      delete :destroy, {id: @stat.to_param}
      response.should redirect_to(batting_statistics_url)
    end
  end

end
