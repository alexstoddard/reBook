class CreateInventoryNeeds < ActiveRecord::Migration
  def change
    create_table :inventory_needs do |t|
      t.integer :book_id
      t.integer :user_id

      t.timestamps
    end
  end
end
