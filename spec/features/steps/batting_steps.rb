########################################################################
# Scoped step definitions for batting statistics page.
########################################################################

steps_for :batting_steps do

  step "you navigate to the batting statistics page" do
    visit batting_statistics_url
  end 
end
