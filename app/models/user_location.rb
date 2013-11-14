class UserLocation < ActiveRecord::Base

  # Relationships
  belongs_to :user
  belongs_to :location

end
