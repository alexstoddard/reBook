class Trade < ActiveRecord::Base

  # Relationships
  has_many :user_feedbacks, dependent: :destroy
  has_many :trade_lines, dependent: :destroy
  has_many :trade_notes, dependent: :destroy

end
