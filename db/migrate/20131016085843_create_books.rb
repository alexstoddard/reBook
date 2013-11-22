class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :subject
      t.string :author
      t.string :edition
      t.decimal :price
      t.string :googleId
      t.string :thumbnail
      t.published :datetime
      t.timestamps
    end
  end
end
