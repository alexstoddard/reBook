class Condition < ActiveRecord::Base

  # Relationships
  has_many :inventory_needs, dependent: :destroy

end
