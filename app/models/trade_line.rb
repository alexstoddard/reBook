class TradeLine < ActiveRecord::Base
  # Callbacks
#  validates :inventory_own_id, uniqueness: true
#  validates :inventory_need_id, uniqueness: true

  # Relationship
  belongs_to :trade
  #  belongs_to :book
  #  delegate :book, :to => :inventory_own
  belongs_to :inventory_need
  belongs_to :inventory_own

end
