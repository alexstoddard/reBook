class InventoryOwn < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  belongs_to :condition
end
