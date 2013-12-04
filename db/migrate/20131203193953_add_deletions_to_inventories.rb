class AddDeletionsToInventories < ActiveRecord::Migration
  def change
  	add_column :inventory_owns, :deleted, :boolean
  	add_column :inventory_needs, :deleted, :boolean
  end
end
