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
  
  end
  
end
