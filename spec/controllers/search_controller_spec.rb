require 'spec_helper'

describe SearchController do

  # Setup improved player data
  let(:improved_players) {
    # Create first few players
    3.times.each do |i|
      FactoryGirl.create(:batting_improves, player_id: "player#{i}", 
        year: '2011', team: 'DET')
      FactoryGirl.create(:batting_improves, player_id: "player#{i}", 
        year: '2012', team: 'DET')
    end
          
    # Create second to last player for two years
    FactoryGirl.create(:batting_improves, player_id: 'fielder01', 
      year: '2011', team: 'DET')
    @fielder12 = FactoryGirl.create(:batting_improves, player_id: 'fielder01', 
      year: '2012', team: 'DET')

    # Create last player for two years
    FactoryGirl.create(:batting_improves, player_id: 'cabrera01', 
      year: '2011', team: 'DET')
    @cabrera12 = FactoryGirl.create(:batting_improves, player_id: 'cabrera01', 
      year: '2012', team: 'DET')
    @player = Player.create!(player_id: 'cabrera01', birth_year: 1980,
      first_name: 'Miggy', last_name: 'Cabrera')
    
    # Make sure batting average and slugging percentage are calculated
    BattingStatistic.each do |stat| 
      stat.batting_average.should > 0
      stat.slugging_percent.should > 0
    end    
  }
  
  before(:each) {BattingStatistic.destroy_all}
  
  
  describe "GET index" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "POST improved" do
    before(:each){
      improved_players
      
      # Put two near the top of the list
      @cabrera12.hits = @cabrera12.hits + 20
      @cabrera12.save
      
      @fielder12.hits = @fielder12.hits + 10
      @fielder12.save      
    }
    
    it "returns http success" do
      post :improved, {start_year: 2011, end_year: 2012, min_at_bats: 200}
      response.should be_success
    end
    
    it "the correct winner should be found" do
      post :improved, {start_year: 2011, end_year: 2012, min_at_bats: 200}
      assigns(:winner).should_not be_empty
      assigns(:winner)[0].should eq(@player.player_id)
      assigns(:player).first_name.should eq(@player.first_name)
    end 
    
    it "should redirect to search index if start_year > end_year" do
      post :improved, {start_year: 2013, end_year: 2011, min_at_bats: 200}
      response.should redirect_to search_index_url(tab: 'tab1')
    end
  end

  describe "POST slugging" do
    before(:each){
      20.times.each { FactoryGirl.create(:team_batting, year: 2007, team: 'OAK') }
      20.times.each { FactoryGirl.create(:team_batting, year: 2011, team: 'DET') }
    }
    
    it "returns http success" do
      post :slugging, {team: 'OAK', year: 2007}
      response.should be_success
    end
    
    it "return the correct team" do
      post :slugging, {team: 'OAK', year: 2007}
      assigns(:stats).each {|stat| stat.team.should eq('OAK')}
    end
    
    it "return the slugging percent for each player" do
      post :slugging, {team: 'OAK', year: 2007}
      assigns(:stats).each {|stat| stat.slugging_percent.should > 0}
    end
    
    it "return the correct number of players" do
      stats = BattingStatistic.where(team: 'OAK', year: 2007)
      post :slugging, {team: 'OAK', year: 2007}
      assigns(:stats).count.should eq(stats.count)
    end    

    it "should redirect to search index if year parameter is missing" do
      post :slugging, {team: 'OAK'}
      response.should redirect_to search_index_url(tab: 'tab2')
    end 
    
    it "should redirect to search index if team parameter is missing" do
      post :slugging, {year: 2007}
      response.should redirect_to search_index_url(tab: 'tab2')
    end        
  end

  describe "POST fantasy_improved" do
    before(:each){
      improved_players
      
      # Put two near the top of the list
      @cabrera12.home_runs = @cabrera12.home_runs + 20
      @cabrera12.save
      
      @fielder12.home_runs = @fielder12.home_runs + 10
      @fielder12.save
      
      FantasyPoint.create!(
        home_run: 4,
        rbi: 1,
        stolen_base: 1,
        caught_stealing: -1
      )   
    }
    
    it "returns http success" do
      post :fantasy_improved, {start_year: 2011, end_year: 2012, min_at_bats: 200}
      response.should be_success
    end
    
    it "should find at least 5 players" do
      post :fantasy_improved, {start_year: 2011, end_year: 2012, min_at_bats: 200}
      assigns(:results).count.should >= 5
    end
    
    it "should find the correct top to players" do
      post :fantasy_improved, {start_year: 2011, end_year: 2012, min_at_bats: 200}
      assigns(:results)[0][0].should eq(@cabrera12.player_id)
      assigns(:results)[1][0].should eq(@fielder12.player_id)
    end
    
    it "should redirect to search index if start_year > end_year" do
      post :fantasy_improved, {start_year: 2013, end_year: 2011, min_at_bats: 200}
      response.should redirect_to search_index_url(tab: 'tab3')
    end    
  end

  describe "POST triple_crown" do
    before(:each){
      improved_players
      
      # Put cabrera at the top of the list
      @cabrera12.home_runs = @cabrera12.home_runs + 20
      @cabrera12.hits = @cabrera12.hits + 30
      @cabrera12.runs_batted_in = @cabrera12.runs_batted_in + 40
      @cabrera12.save
    }
    
    it "returns http success" do
      post :triple_crown, {year: 2012}
      response.should be_success
    end
    
    it "should return a winner" do
      post :triple_crown, {year: 2012}
      assigns(:player).should be_present
    end
    
    it "should return a the correct player as winner" do
      post :triple_crown, {year: 2012}
      assigns(:player).player_id.should eq(@cabrera12.player_id)
    end    
  end

end
