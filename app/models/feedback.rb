class Feedback < ActiveRecord::Base

  # Relationships
  has_many :user_feedbacks, dependent: :destroy

end
