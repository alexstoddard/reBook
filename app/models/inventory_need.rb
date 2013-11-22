class InventoryNeed < ActiveRecord::Base

  # Relationships
  belongs_to :book
  belongs_to :user
  belongs_to :condition
  
  has_many :own_matches, class_name: "InventoryOwn",
                          foreign_key: "book_id", 
                          primary_key: "book_id"

  has_many :user_owns, class_name: "InventoryOwn",
                       foreign_key: "user_id", 
                       primary_key: "user_id"
  
  has_many :trade_lines
  has_many :trades, through: :trade_lines
  
  before_destroy :destroy_trades

  def destroy_trades
    @trades = trades.all
    @trades.each { |x| x.destroy }
  end
  
end
