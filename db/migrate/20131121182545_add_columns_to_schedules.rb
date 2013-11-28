class AddColumnsToSchedules < ActiveRecord::Migration
  def change
    add_column :user_schedules, :from, :integer
    add_column :user_schedules, :to, :integer
    add_column :user_schedules, :day, :string
  end
end
