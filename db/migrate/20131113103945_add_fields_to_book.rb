class AddFieldsToBook < ActiveRecord::Migration
  def change
    add_column :books, :isbn, :string
    add_column :books, :published, :datetime
    add_column :books, :description, :text
  end
end
