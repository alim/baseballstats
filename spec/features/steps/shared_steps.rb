########################################################################
# Scoped step definitions shared across all feature definitions
########################################################################

step 'you click on the :link_name link' do |link_name|
  click_on "#{link_name}"
end

step 'you should see the :title page' do |title|
  page.should have_content "#{title}"
end

