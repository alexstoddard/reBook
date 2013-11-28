class UserLocation < ActiveRecord::Base

  # Relationships
  belongs_to :user
  belongs_to :location
  has_many :user_schedules, :dependent => :destroy
  validates_uniqueness_of :user_id, :scope => :location_id

end
