class Location < ActiveRecord::Base

  # Relationships
  has_many :user_locations, dependent: :destroy
  has_many :users, through: :user_locations
  
  def self.search_user(user_id, search)
    return Location.search(search).select { |x| x.user_locations.find_by_user_id(user_id).nil? }

  end

  def self.search(search) 
    if search.nil?
      locations = []
    else
      locations = Location.find(:all, :conditions => 
                                 ['name LIKE ? OR description LIKE ?', ["%#{search}%"]*2].flatten)
    end

    return locations
  end
end
