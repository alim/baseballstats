require 'spec_helper'

describe "fantasy_points/edit" do
  before(:each) do
    @fantasy_point = assign(:fantasy_point, stub_model(FantasyPoint,
      :home_run => "",
      :rbi => "",
      :stolen_base => "",
      :caught_stealing => ""
    ))
  end

  it "renders the edit fantasy_point form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", fantasy_point_path(@fantasy_point), "post" do
      assert_select "input#fantasy_point_home_run[name=?]", "fantasy_point[home_run]"
      assert_select "input#fantasy_point_rbi[name=?]", "fantasy_point[rbi]"
      assert_select "input#fantasy_point_stolen_base[name=?]", "fantasy_point[stolen_base]"
      assert_select "input#fantasy_point_caught_stealing[name=?]", "fantasy_point[caught_stealing]"
    end
  end
end
