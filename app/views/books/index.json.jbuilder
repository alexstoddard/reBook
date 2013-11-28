json.array!(@books) do |book|
  json.extract! book, :name, :subject, :author, :edition, :price, :googleId, :thumbnail
  json.url book_url(book, format: :json)
end
