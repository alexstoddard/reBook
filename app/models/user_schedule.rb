class UserSchedule < ActiveRecord::Base
  belongs_to :user_location
  after_initialize :set_formats
  validate :validate_times

  def set_formats
    @@military = "%H%M"
    @@standard = "%I:%M%P"

    Time::DATE_FORMATS[:military] = @@military
    Time::DATE_FORMATS[:standard] = @@standard
  end

  def self.format_military(time)
    begin
      t = DateTime.strptime(time, @@standard)
      return t.to_s(:military).to_i
    rescue
      return "00:00am"
    end
  end

  def validate_times
    if to <= from
      errors.add(:to, "To must be greater than from")
      errors.add(:from, "To must be greater than from")
    end
  end

  def self.format_standard(time)
    begin
      time_string = time.to_s
      if time_string.length == 3
        time_string = "0" + time_string
      end
      t = DateTime.strptime(time_string, @@military)
      return t.to_s(:standard)
    rescue
      return "00:00am"
    end
  end

  def to_standard
    return UserSchedule.format_standard(self.to)
  end

  def from_standard
    return UserSchedule.format_standard(self.from)
  end
  
  def to_standard=(time)
    begin
      self.to = UserSchedule.format_military(time)
    rescue
      self.to = 0
    end
  end

  def from_standard=(time)
    begin
      self.from = UserSchedule.format_military(time)
    rescue
      self.from = 0
    end
  end

end
