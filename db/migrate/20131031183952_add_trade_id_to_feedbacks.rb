class AddTradeIdToFeedbacks < ActiveRecord::Migration
  def change
	add_column :user_feedbacks, :trade_id, :integer
  end
end
