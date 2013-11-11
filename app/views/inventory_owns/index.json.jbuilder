json.array!(@inventory_owns) do |inventory_own|
  json.extract! inventory_own, :book_id, :user_id, :condition
  json.url inventory_own_url(inventory_own, format: :json)
end
