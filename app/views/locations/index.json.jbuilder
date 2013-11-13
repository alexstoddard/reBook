json.array!(@locations) do |location|
  json.extract! location, :name, :address, :city, :state, :zip, :image, :icon, :description
  json.url location_url(location, format: :json)
end
