class AddLocationToTrade < ActiveRecord::Migration
  def change
    add_column :trades, :location_id, :integer
  end
end
