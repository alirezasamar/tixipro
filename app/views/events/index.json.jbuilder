json.array!(@events) do |event|
  json.extract! event, :id, :name, :description, :genre, :start, :end
  json.url event_url(event, format: :json)
end
