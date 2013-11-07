class CreateInventoryOwns < ActiveRecord::Migration
  def change
    create_table :inventory_owns do |t|
      t.integer :book_id
      t.integer :user_id
      t.string :condition

      t.timestamps
    end
  end
end
