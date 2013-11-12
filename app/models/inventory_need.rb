class InventoryNeed < ActiveRecord::Base

  # Relationships
  belongs_to :book
  belongs_to :user
  belongs_to :condition

end
