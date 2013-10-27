json.array!(@inventory_haves) do |inventory_hafe|
  json.extract! inventory_hafe, :book_id, :user_id, :condition_id
  json.url inventory_hafe_url(inventory_hafe, format: :json)
end
