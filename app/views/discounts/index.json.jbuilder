json.array!(@discounts) do |discount|
  json.extract! discount, :id, :ticket_id, :discount_percentage, :code
  json.url discount_url(discount, format: :json)
end
