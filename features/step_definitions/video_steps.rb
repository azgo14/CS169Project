Given /the following videos exist/ do |videos_table|
  videos_table.hashes.each do |video|
    Video.create(video)
  end
end

Given /I am signed in as an administrator/ do
  admin = User.create(:email => 'admin@api.com', :password => 'password')
  admin.admin = true
  admin.save
  When %{I am on the user sign-in page}
  And %{I fill in "user_email" with "admin@api.com"}
  And %{I fill in "user_password" with "password"}
  Then %{I press "Sign in"}
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  match = page.body.gsub(/\n/, "") =~ /#{e1}.*#{e2}/
  assert match!=nil
end

Then /I should see the following under "(.*)": (.*)/ do |status, video_list|
  video_list.split(/,\s*/).each do |video|
    Then %{I should see "#{status}" before "#{video}"}
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
    When %{I check "#{ethnicity}"}
  end
end
