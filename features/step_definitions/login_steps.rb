Given /^I am not logged in$/ do
  visit("/users/sign_out")
end

Given /^the following user exists:$/ do |table|
  table.hashes.each do |user_row|
    user = User.new
    user.email = user_row[:email]
    user.password = user_row[:password]
    user.admin = user_row[:admin]
    user.save
  end
end

Given /^the following user does not exist:$/ do |table|
  table.hashes.each do |user_row|
    user = User.find_by_email(user_row[:email])
    if !user.nil?
      user.destroy
    end
  end
end

Given /I am signed in as a user$/ do
  user = User.create(:email => "test@test.com", :password => "qwerty")
  step %{I am on the user sign-in page}
  step %{I fill in "user_email" with "test@test.com"}
  step %{I fill in "user_password" with "qwerty"}
  step %{I press "Sign in"}
end

Then /^I should see "([^"]*)" button/ do |name|
  find_button(name).should_not be_nil
end

Then /^I should not see "([^"]*)" button/ do |name|
  find_button(name).should_not be_nil
end

Given /I am signed in as a blocked user$/ do
  user = User.create(:email => "test@test.com", :password => "qwerty", :blocked => true)
  step %{I am on the user sign-in page}
  step %{I fill in "user_email" with "test@test.com"}
  step %{I fill in "user_password" with "qwerty"}
  step %{I press "Sign in"}
end
