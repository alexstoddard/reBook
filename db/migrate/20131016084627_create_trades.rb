class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.string :status

      t.timestamps
    end
  end
end
