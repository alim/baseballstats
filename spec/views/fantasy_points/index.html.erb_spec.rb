require 'spec_helper'

describe "fantasy_points/index" do
  before(:each) do
    assign(:fantasy_points, [
      stub_model(FantasyPoint,
        :home_run => "",
        :rbi => "",
        :stolen_base => "",
        :caught_stealing => ""
      ),
      stub_model(FantasyPoint,
        :home_run => "",
        :rbi => "",
        :stolen_base => "",
        :caught_stealing => ""
      )
    ])
  end

  it "renders a list of fantasy_points" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
