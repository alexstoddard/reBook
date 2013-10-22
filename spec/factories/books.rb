# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    name "MyString"
    subject "MyString"
    author "MyString"
    edition "MyString"
    price "9.99"
    googleId "MyString"
    thumbnail "MyString"
  end
end
