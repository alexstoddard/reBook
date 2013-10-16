json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :type, :image
  json.url feedback_url(feedback, format: :json)
end
