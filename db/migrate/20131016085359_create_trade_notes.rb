class CreateTradeNotes < ActiveRecord::Migration
  def change
    create_table :trade_notes do |t|
      t.integer :trade_id
      t.datetime :meet_time
      t.string :place
      t.text :comment
      t.integer :user_id

      t.timestamps
    end
  end
end
