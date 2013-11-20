class ChangeMeetTimeInTradeNote < ActiveRecord::Migration
  def self.up
	change_column :trade_notes, :meet_time, :text
  end
  
  def self.down
	change_column :trade_notes, :meet_time, :datetime
  end
end
