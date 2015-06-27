json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :type, :price, :price, :free, :quantity, :event_id
  json.url ticket_url(ticket, format: :json)
end
