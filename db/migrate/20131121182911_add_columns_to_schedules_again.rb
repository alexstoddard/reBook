class AddColumnsToSchedulesAgain < ActiveRecord::Migration
  def change
    add_column :user_schedules, :user_location_id, :integer
  end
end
