# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    subject "MyText"
    message "MyText"
    status "MyString"
    from_user "MyString"
    to_user "MyString"
  end
end
