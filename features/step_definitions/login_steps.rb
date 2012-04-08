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
