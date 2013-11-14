json.array!(@trades) do |trade|
  json.extract! trade, :status
  json.url trade_url(trade, format: :json)
end
