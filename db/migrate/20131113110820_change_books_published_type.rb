class ChangeBooksPublishedType < ActiveRecord::Migration
  def self.up
	change_column :books, :published, :string
  end
  
  def self.down
	change_column :books, :published, :datetime
  end
end
