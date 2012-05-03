Given /the following videos exist/ do |videos_table|
  videos_table.hashes.each do |video|
    Video.create(video)
  end
end

Given /I am signed in as an administrator/ do
  admin = User.create(:email => 'admin@api.com', :password => 'password')
  admin.admin = true
  admin.save
  step %{I am on the user sign-in page}
  step %{I fill in "user_email" with "admin@api.com"}
  step %{I fill in "user_password" with "password"}
  step %{I press "Sign in"}
end

Given /I am signed in as a registered user/ do
  user = User.find_by_email('user@api.com')
  if(user.blank?)
    User.create(:email => 'user@api.com', :password => 'password')
  end
  step %{I am on the user sign-in page}
  step %{I fill in "user_email" with "user@api.com"}
  step %{I fill in "user_password" with "password"}
  step %{I press "Sign in"}
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  match = page.body.gsub(/\n/, "") =~ /#{e1}.*#{e2}/
  assert match!=nil
end

Then /I should see the following under "(.*)": (.*)/ do |status, video_list|
  video_list.split(/,\s*/).each do |video|
    step %{I should see "#{status}" before "#{video}"}
  end
end

Given /^(?:|I )am on (.+)?/ do |page_name|
  if page_name =~ /the admin video detail page for "([^"]*)"$/
    video = Video.find_by_name($1)
    visit admin_video_path(video)
  else
    visit path_to(page_name)
  end
 end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if page_name =~ /the admin video detail page for "([^"]*)"$/
    video = Video.find_by_name($1)
    assert_equal admin_video_path(video), current_path
  elsif current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

When /I check the following ethnicities: (.*)/ do |ethnicity_list|
  ethnicity_list.split(/,\s*/).each do |ethnicity|
    step %{I check "#{ethnicity}"}
  end
end

Then /I should not see any comments/ do
  page.should_not have_css(".comment")
end

Then /I should not see any notes/ do
  assert page.find_by_id('video_notes').text.blank?
end

Then /the "([^"]*)" field should be empty/ do |field|
  field = find_field(field)
  field_value = (field.tag_name == 'textarea') ? field.text : field.value
  assert field_value.blank?
end
