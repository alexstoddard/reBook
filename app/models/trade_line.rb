class TradeLine < ActiveRecord::Base
  # Relationship
  belongs_to :trade
  belongs_to :user_from, :class_name=> 'User', :foreign_key => 'user_from_id'
  belongs_to :user_to, :class_name=> 'User', :foreign_key => 'user_to_id'

end
