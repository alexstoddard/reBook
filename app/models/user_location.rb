class UserLocation < ActiveRecord::Base

  # Relationships
  belongs_to :user
  belongs_to :location
  has_many :user_schedules, :dependent => :destroy
  has_many :inventory_owns
  has_many :books, through: :inventory_owns
  validates_uniqueness_of :user_id, :scope => :location_id

end
