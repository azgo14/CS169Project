And /I am signed in as user ([0-9]*)/ do |id|
  user = User.create(:email => "test@test.com", :password => "qwerty", :id => id)
  step %{I am on the user sign-in page}
  step %{I fill in "user_email" with "test@test.com"}
  step %{I fill in "user_password" with "qwerty"}
  step %{I press "Sign in"}
end
