json.array!(@halls) do |hall|
  json.extract! hall, :id, :name, :description, :total_seat, :seat_view
  json.url hall_url(hall, format: :json)
end
