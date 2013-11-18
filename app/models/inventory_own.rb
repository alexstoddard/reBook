class InventoryOwn < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  belongs_to :condition

  has_many :need_matches, class_name: "InventoryNeed",
                          foreign_key: "book_id", primary_key: "book_id"

  has_many :user_needs, class_name: "InventoryNeed",
                       foreign_key: "user_id", primary_key: "user_id"
end
