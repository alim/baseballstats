require 'spec_helper'

describe BattingStatistic do
  
  # Attribute checks ---------------------------------------------------
  describe "Attribute/method checks" do
    it { should respond_to :player_id }
    it { should respond_to :year }
    it { should respond_to :team }
    it { should respond_to :games_played }
    it { should respond_to :at_bats }
    it { should respond_to :runs_scored }
    it { should respond_to :hits }
    it { should respond_to :doubles }
    it { should respond_to :triples }
    it { should respond_to :home_runs }
    it { should respond_to :runs_batted_in }
    it { should respond_to :stolen_bases }
    it { should respond_to :caught_stealing }
    it { should respond_to :batting_average }
    it { should respond_to :slugging_percent }
  end
    
  # Validation tests ---------------------------------------------------
  describe "Validation tests" do
    before(:each){
      @stat = BattingStatistic.new(
        player_id: "anderjo03", 
        year: "2009", 
        team: "DET", 
        games_played: 74, 
        at_bats: 165, 
        runs_scored: 22, 
        hits: 40, 
        doubles: 4, 
        triples: 4, 
        home_runs: 0, 
        runs_batted_in: 16, 
        stolen_bases: 13, 
        caught_stealing: 2      
      )
    }  
  
    it "should be valid with complete statistics" do
      @stat.should be_valid
    end
    
    it "should NOT be valid with empty statistics attributes" do
      stat = BattingStatistic.new
      stat.should_not be_valid
    end
    
    it "should calculate batting average" do
      @stat.save
      @stat.batting_average.should_not be_nil
      @stat.batting_average.should eq(@stat.hits/@stat.at_bats.to_f)
    end
    
    it "should calculate slugging percentage" do
      spercent = ((@stat.hits - @stat.doubles - @stat.triples - @stat.home_runs) + 
        (2 * @stat.doubles) + (3 * @stat.triples) + 
        (4 * @stat.home_runs)) / @stat.at_bats.to_f
      @stat.save
      @stat.slugging_percent.should_not be_nil
      @stat.slugging_percent.should eq(spercent)
    end
    
    it "should be invalid with negative games_played" do
      @stat.games_played = -10
      @stat.should_not be_valid
    end

    it "should be invalid with negative at_bats" do
      @stat.at_bats = -123
      @stat.should_not be_valid
    end
    
    it "should be invalid with negative runs_scored" do
      @stat.runs_scored = -999
      @stat.should_not be_valid
    end
    
    it "should be invalid with negative hits" do
      @stat.hits = -234
      @stat.should_not be_valid
    end
    
    it "should be invalid with negative doubles" do
      @stat.doubles = -434
      @stat.should_not be_valid
    end
    
    it "should be invalid with negative triples" do
      @stat.triples = -678
      @stat.should_not be_valid
    end
    
    it "should be invalid with negative home_runs" do
      @stat.home_runs = -6
      @stat.should_not be_valid
    end
    
    it "should be invalid with negative runs_batted_in" do
      @stat.runs_batted_in = -876
      @stat.should_not be_valid
    end
    
    it "should be invalid with negative stolen_bases" do
      @stat.stolen_bases = -765
      @stat.should_not be_valid
    end

    it "should be invalid with negative caught_stealing" do
      @stat.caught_stealing = -765
      @stat.should_not be_valid
    end    
  end  
    
  # IMPORTING TESTS ----------------------------------------------------
  
  describe "CSV import tests" do
    before(:each) { 
      @csvfile = File.new(Rails.root + 'spec/data/batting_stats_test.csv')
      @rcount = @csvfile.readlines.count - 1
      
      @csvfile.rewind  
      
      # Create a reference to an uploaded file like Rails would do
      @newfile = ActionDispatch::Http::UploadedFile.new(tempfile: @csvfile, 
        filename:  File.basename(@csvfile))  
    }
    
    it "should import the corrent number of records" do
      BattingStatistic.import(@newfile)
      BattingStatistic.count.should eq(@rcount)
    end
    
    it "should have all valid records" do
      BattingStatistic.each { |stat| stat.should be_valid }
    end
  end
end
