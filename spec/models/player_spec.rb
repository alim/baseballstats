require 'spec_helper'

describe Player do
  
  # Attribute checks ---------------------------------------------------
  describe "Attribute/method checks" do
    it { should respond_to :player_id }
    it { should respond_to :birth_year }
    it { should respond_to :first_name }
    it { should respond_to :last_name }
  end
    
  # Validation tests ---------------------------------------------------
  describe "Validation tests" do
    before(:each){
      @player = Player.new(
        player_id: "aaronha01", 
        birth_year: 1934, 
        first_name: "Hank", 
        last_name: "Aaron", 
      )
    }  
  
    it "should be valid with complete playter attributes" do
      @player.should be_valid
    end
    
    it "should NOT be valid with empty player attributes" do
      player = Player.new
      player.should_not be_valid
    end
    
    it "should be invalid with negative birth_year" do
      @player.birth_year = -10
      @player.should_not be_valid
    end
    
    it "should be invalid with birth_year less than 1700" do
      @player.birth_year = 1492
      @player.should_not be_valid
    end    
  end  
    
  # IMPORTING TESTS ----------------------------------------------------
  
  describe "CSV import tests" do
    before(:each) { 
      @csvfile = File.new(Rails.root + 'spec/data/player_test.csv')
      @rcount = @csvfile.readlines.count - 1
      
      @csvfile.rewind  
      
      # Create a reference to an uploaded file like Rails would do
      @newfile = ActionDispatch::Http::UploadedFile.new(tempfile: @csvfile, 
        filename:  File.basename(@csvfile))  
    }
    
    it "should import the corrent number of records" do
      Player.import(@newfile)
      @rcount = @rcount - Player.skipped
      Player.count.should eq(@rcount)
    end
    
    it "should have all valid records" do
      Player.each { |player| player.should be_valid }
    end
  end
end
