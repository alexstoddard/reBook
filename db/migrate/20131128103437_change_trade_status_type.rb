class ChangeTradeStatusType < ActiveRecord::Migration
 def up
    change_table :trades do |t|
      t.change :status, :integer
    end
  end
 
  def down
    change_table :trades do |t|
      t.change :status, :string
    end
  end
end
