class ChangeTradeNoteType < ActiveRecord::Migration
  def change
  	change_table :trade_notes do |t|
      t.remove :type
      t.string :note_type
    end
  end
end
