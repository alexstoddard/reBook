class ChangeColumnToIntegerToInventoryOwns < ActiveRecord::Migration
  def self.up
	change_column :inventory_owns, :condition, :integer
  end
  
  def self.down
	change_column :inventory_owns, :condition, :string
  end
end
