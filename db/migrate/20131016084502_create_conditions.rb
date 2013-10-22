class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
