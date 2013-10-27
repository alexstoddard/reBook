class CreateInventoryHaves < ActiveRecord::Migration
  def change
    create_table :inventory_haves do |t|
      t.integer :book_id
      t.integer :user_id
      t.string :condition_id

      t.timestamps
    end
  end
end
