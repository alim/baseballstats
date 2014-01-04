########################################################################
# Scoped step definitions for players page.
########################################################################

steps_for :player_steps do

  step "you navigate to the players page" do
    visit players_url
  end 
  
  step "there are player records" do
    50.times.each { FactoryGirl.create(:player) }
  end

end
