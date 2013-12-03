class AddTypeToTradeNotes < ActiveRecord::Migration
  def change
  	add_column :trade_notes, :type, :string
  end
end
