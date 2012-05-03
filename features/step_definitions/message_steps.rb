Given /the following messages exist/ do |messages_table|
  messages_table.hashes.each do |message|
    if message[:from_user] == 'admin'
      message[:from_user] = -1
    end
    if message[:to_user] == 'admin'
      message[:to_user] = -1
    end
    Message.create(message)
  end
end

And /I should see the message "(.*)"/ do |subject|
  page.should have_selector(".message", :text => subject)
end

And /I should not see the message "(.*)"/ do |subject|
  page.should_not have_selector(".message", :text => subject)
end

Given /I set up accounts for messages because Devise is silly/ do
  admin = User.create(:email => "test22@test.com", :password => "qwerty")
  admin.admin = true
  admin.save!
  user = User.create(:email => "test@test.com", :password => "qwerty")
end


Given /I am signed in as an admin for messages$/ do
  step %{I am on the user sign-in page}
  step %{I fill in "user_email" with "test22@test.com"}
  step %{I fill in "user_password" with "qwerty"}
  step %{I press "Sign in"}
end

Given /I am signed in as a user for messages$/ do
  step %{I am on the user sign-in page}
  step %{I fill in "user_email" with "test@test.com"}
  step %{I fill in "user_password" with "qwerty"}
  step %{I press "Sign in"}
end



