# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    content 'Some comment content'
    status 'pending'
    anonymous 'true'
  end
end
