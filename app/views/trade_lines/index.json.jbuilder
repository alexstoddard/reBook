json.array!(@trade_lines) do |trade_line|
  json.extract! trade_line, :user_from_id, :book_id, :user_to_id, :user_from_accepted
  json.url trade_line_url(trade_line, format: :json)
end
