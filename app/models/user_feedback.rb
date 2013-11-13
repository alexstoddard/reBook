class UserFeedback < ActiveRecord::Base

  # Relationships
  belongs_to :feedback
  belongs_to :user_from, :class_name=> 'User', :foreign_key => 'user_from_id'
  belongs_to :user_to, :class_name=> 'User', :foreign_key => 'user_to_id'
  belongs_to :trade

end
