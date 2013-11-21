json.array!(@user_schedules) do |user_schedule|
  json.extract! user_schedule, 
  json.url user_schedule_url(user_schedule, format: :json)
end
