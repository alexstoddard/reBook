class UpdateUserFeedbacks < ActiveRecord::Migration
  def change
  	
  	change_table :user_feedbacks do |t|
      t.remove :comment, :feedback_id
      t.integer :score
    end
  	
  	drop_table :feedbacks
  end
end
