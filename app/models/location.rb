class Location < ActiveRecord::Base

  # Relationships
  has_many :user_locations, dependent: :destroy
  has_many :users, through: :user_locations

end
