json.array!(@users) do |user|
  json.extract! user, :username, :email, :passhash, :image
  json.url user_url(user, format: :json)
end
