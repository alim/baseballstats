########################################################################
# Scoped step definitions shared across all feature definitions
########################################################################

step 'you click on the :link_name link' do |link_name|
  click_on "#{link_name}"
end

step 'you should see the :title page' do |title|
  page.should have_content "#{title}"
end
  
step "you fill in file with :filename" do |filename|
  full_pathname = Rails.root + filename
  page.attach_file("file", full_pathname )
end

step "you should see a :msg message" do |message|
  page.should have_content "#{message}"
end


