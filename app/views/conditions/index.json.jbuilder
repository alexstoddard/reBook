json.array!(@conditions) do |condition|
  json.extract! condition, :description, :image
  json.url condition_url(condition, format: :json)
end
