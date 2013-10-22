# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trade_line do
    user_from_id 1
    book_id 1
    user_to_id 1
    user_from_accepted false
  end
end
