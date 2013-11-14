class InventoryNeed < ActiveRecord::Base

  # Relationships
  belongs_to :book
  belongs_to :user
  belongs_to :condition
  
  has_many :own_matches, class_name: "InventoryOwn",
                          foreign_key: "book_id", primary_key: "book_id"

end
