# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    user_id
    comment
    status 'pending'
    video_id
  end
end
