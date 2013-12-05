class ChangeTradeStatusType < ActiveRecord::Migration
 def up
    change_table :trades do |t|
      t.remove :status
      t.integer :status
    end
  end
 
  def down
    change_table :trades do |t|
      t.remove :status
      t.string :status
    end
  end
end
