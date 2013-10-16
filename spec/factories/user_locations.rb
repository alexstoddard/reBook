# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_location do
    user_id 1
    location_id 1
    description "MyString"
  end
end
