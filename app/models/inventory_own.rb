class InventoryOwn < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  belongs_to :condition
  has_many :need_matches, class_name: "InventoryNeed",
                          foreign_key: "book_id", primary_key: "book_id"

  has_many :user_needs, class_name: "InventoryNeed",
                       foreign_key: "user_id", primary_key: "user_id"

  has_many :trade_lines
  has_many :trades, through: :trade_lines

  before_destroy :destroy_trades

  scope :need_matches_scope, -> { joins(:need_matches).where('inventory_needs.deleted = ?', false) }
  scope :active, -> { where(deleted: false) }
  scope :user, -> (user) { where(:user_id => user) }

  def destroy_trades
    @trades = trades.all
    @trades.each { |x| x.destroy }
  end

end
