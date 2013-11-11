class AddTradeIdToTradeLines < ActiveRecord::Migration
  def change
	add_column :trade_lines, :trade_id, :integer
  end
end
