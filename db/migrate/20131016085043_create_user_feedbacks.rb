class CreateUserFeedbacks < ActiveRecord::Migration
  def change
    create_table :user_feedbacks do |t|
      t.integer :user_from_id
      t.integer :user_to_id
      t.integer :feedback_id
      t.text :comment
      t.integer: trade_id
      t.timestamps
    end
  end
end
