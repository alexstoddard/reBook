class UserLocation < ActiveRecord::Base

  # Relationships
  belongs_to :user
  belongs_to :location
  has_many :user_schedules, :dependent => :destroy
  has_many :inventory_owns
  has_many :books, through: :inventory_owns
  validates_uniqueness_of :user_id, :scope => :location_id

  def schedule_hash
    days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    output = { }

    days.each do |day|
      output[day] = Array.new(48) { false }
    end

    user_schedules.each do |schedule|
      from = ((schedule.from/100)*60) + (schedule.from%100)
      to = ((schedule.to/100)*60) + (schedule.to%100)

      (from..(to-1)).step(30) do |minute|
        output[schedule.day][minute/30] = true
      end
    end

    return output

  end
  
  def self.combine_schedules(schedules) 

    days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    output = { }

    days.each do |day|
      output[day] = Array.new(48) { 0 }
    end
    
    schedules.each do |schedule|
      days.each do |day|
        (0..47).each do |minute| 
          if schedule[day][minute]
            output[day][minute] += 1
          end
        end
      end
    end

    return output
  end
  
end
