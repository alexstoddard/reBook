class TradeLine < ActiveRecord::Base
  # Relationship
  belongs_to :trade
  #  belongs_to :book
  #  delegate :book, :to => :inventory_own
  belongs_to :inventory_need
  belongs_to :inventory_own

end
