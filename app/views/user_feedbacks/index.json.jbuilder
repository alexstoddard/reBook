json.array!(@user_feedbacks) do |user_feedback|
  json.extract! user_feedback, :user_from_id, :user_to_id, :trade_id, :score
  json.url user_feedback_url(user_feedback, format: :json)
end
