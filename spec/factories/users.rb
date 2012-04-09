FactoryGirl.define do
  factory :user do
    email "user@api.com"
    password "apiUser"
    admin false
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    email "admin@api.com"
    password "apiAdmin"
    admin true
  end
end
