class ChangeInventoryOwnsCondition < ActiveRecord::Migration
  def self.up
    remove_column :inventory_owns, :condition
    add_column :inventory_owns, :condition_id, :integer
  end

  def self.down
    remove_column :inventory_owns, :condition_id
    add_column :inventory_owns, :condition, :integer
  end
end
