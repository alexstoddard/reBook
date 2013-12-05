class AddStatusToTradeLine < ActiveRecord::Migration
  def change
  	add_column :trade_lines, :status, :integer, :default => 0
  end
end
