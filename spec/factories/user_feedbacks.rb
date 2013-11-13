# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_feedback do
    user_from_id 1
    user_to_id 1
    feedback_id 1
    comment "MyText"
  end
end
