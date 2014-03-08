json.array!(@events) do |event|
  json.extract! event, :id, :user_id, :title, :s_date, :e_date, :s_time, :e_time, :description, :twitter_hash_tag
  json.url event_url(event, format: :json)
end
