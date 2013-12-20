########################################################################
# Scoped step definitions for home page features.
########################################################################

steps_for :home_steps do

  step 'you navigate to the home url' do
    visit root_url
  end
  
  step 'you should see a :title_word in the title' do |title|
    page.should have_content "#{title}"
  end
  
  step 'you should see a navigation bar' do
    page.should have_css 'div.navbar'
  end
  
  step 'you click on the :link_name link' do |link_name|
    click_on "#{link_name}"
  end
  
  step 'you should see the :title page' do |title|
    page.should have_content "#{title}"
  end
end
