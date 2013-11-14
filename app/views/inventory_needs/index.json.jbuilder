json.array!(@inventory_needs) do |inventory_need|
  json.extract! inventory_need, :book_id, :user_id
  json.url inventory_need_url(inventory_need, format: :json)
end
