########################################################################
# Scoped step definitions for batting statistics page.
########################################################################

steps_for :batting_steps do

  step "you navigate to the batting statistics page" do
    visit batting_statistics_url
  end 
  
  step "there are batting statistics" do
    25.times.each { FactoryGirl.create(:batting_statistic) }
  end

end
