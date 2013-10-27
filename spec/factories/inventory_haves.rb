# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inventory_hafe, :class => 'InventoryHave' do
    book_id 1
    user_id 1
    condition_id "MyString"
  end
end
