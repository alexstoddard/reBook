# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inventory_own do
    book_id 1
    user_id 1
    condition "MyString"
  end
end
