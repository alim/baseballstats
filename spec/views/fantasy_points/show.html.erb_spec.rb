require 'spec_helper'

describe "fantasy_points/show" do
  before(:each) do
    @fantasy_point = assign(:fantasy_point, stub_model(FantasyPoint,
      :home_run => "",
      :rbi => "",
      :stolen_base => "",
      :caught_stealing => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end
