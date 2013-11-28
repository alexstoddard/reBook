class CreateUserSchedules < ActiveRecord::Migration
  def change
    create_table :user_schedules do |t|

      t.timestamps
    end
  end
end
