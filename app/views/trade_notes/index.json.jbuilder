json.array!(@trade_notes) do |trade_note|
  json.extract! trade_note, :trade_id, :meet_time, :place, :comment, :user_id
  json.url trade_note_url(trade_note, format: :json)
end
