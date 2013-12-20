require 'spec_helper'

describe FantasyPoint do
  
  # Attribute checks ---------------------------------------------------
  describe "Attribute/method checks" do
    it { should respond_to :home_run }
    it { should respond_to :rbi }
    it { should respond_to :stolen_base }
    it { should respond_to :caught_stealing }
  end
  
  # Validation checks --------------------------------------------------
  describe "Validation checks" do
    before(:each){
      @fantasy_points = FantasyPoint.new(home_run: 1, rbi: 2, 
        stolen_base: 3, caught_stealing: 4)
    }
    
    it "should only allow one record to be saved" do
      @fantasy_points.save
      FantasyPoint.count.should eq(1)
      @fantasy_points2 = FantasyPoint.new(home_run: 1, rbi: 2, 
        stolen_base: 3, caught_stealing: 4)
      @fantasy_points2.save.should_not be_true
    end
    
    it "should not be valid with an emtpy home_run" do
      @fantasy_points.home_run = nil
      @fantasy_points.should_not be_valid
    end

    it "should not be valid with an non-integer home_run" do
      @fantasy_points.home_run = 1.1
      @fantasy_points.should_not be_valid
      @fantasy_points.home_run = 'a'
      @fantasy_points.should_not be_valid
    end     
    
    it "should not be valid with an emtpy rbi" do
      @fantasy_points.rbi = nil
      @fantasy_points.should_not be_valid
    end 
    
    it "should not be valid with an non-integer rbi" do
      @fantasy_points.rbi = 1.444
      @fantasy_points.should_not be_valid
      @fantasy_points.rbi = 'a'
      @fantasy_points.should_not be_valid
    end    

    it "should not be valid with an emtpy stolen_base" do
      @fantasy_points.stolen_base = nil
      @fantasy_points.should_not be_valid
    end 
    
    it "should not be valid with an non-integer stolen_base" do
      @fantasy_points.stolen_base = 1.444
      @fantasy_points.should_not be_valid
      @fantasy_points.stolen_base = 'a'
      @fantasy_points.should_not be_valid
    end     

    it "should not be valid with an emtpy caught_stealing" do
      @fantasy_points.caught_stealing = nil
      @fantasy_points.should_not be_valid
    end 
    
    it "should not be valid with an non-integer caught_stealing" do
      @fantasy_points.caught_stealing = 1.444
      @fantasy_points.should_not be_valid
      @fantasy_points.caught_stealing = 'a'
      @fantasy_points.should_not be_valid
    end  
  end
  
end
