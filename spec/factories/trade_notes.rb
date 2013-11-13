# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trade_note do
    trade_id 1
    meet_time "2013-10-16 08:53:59"
    place "MyString"
    comment "MyText"
    user_id 1
  end
end
