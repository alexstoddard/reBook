class CreateTradeLines < ActiveRecord::Migration
  def change
    create_table :trade_lines do |t|
      t.integer :user_from_id
      t.integer :book_id
      t.integer :user_to_id
      t.boolean :user_from_accepted
	  t.integer :trade_id
      t.timestamps
    end
  end
end
