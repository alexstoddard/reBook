class ChangeTradeLineDefinition < ActiveRecord::Migration
  def self.up
    remove_column :trade_lines, :user_from_id
    remove_column :trade_lines, :user_to_id
    remove_column :trade_lines, :book_id
    add_column :trade_lines, :inventory_own_id, :integer
    add_column :trade_lines, :inventory_need_id, :integer
  end
  
  def self.down
    add_column :trade_lines, :user_from_id, :integer 
    add_column :trade_lines, :user_to_id, :integer
    add_column :trade_lines, :book_id, :integer

    remove_column :trade_lines, :inventory_own_id
    remove_column :trade_lines, :inventory_need_id
  end
end
