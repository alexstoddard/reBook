class Condition < ActiveRecord::Base

  validates :description, :presence => true

  # Relationships
  has_many :inventory_needs, dependent: :destroy

end
