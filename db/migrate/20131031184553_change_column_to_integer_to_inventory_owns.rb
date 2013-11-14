class ChangeColumnToIntegerToInventoryOwns < ActiveRecord::Migration
  def self.up
    remove_column :inventory_owns, :condition
    add_column :inventory_owns, :condition, :integer
  end
  
  def self.down
    remove_column :inventory_owns, :condition
    add_column :inventory_owns, :condition, :string
  end
end
