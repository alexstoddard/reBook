class Book < ActiveRecord::Base

  # Relationships
  has_many :inventory_needs, dependent: :destroy
  has_many :inventory_owns, dependent: :destroy

end
