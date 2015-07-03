json.array!(@orders) do |order|
  json.extract! order, :id, :line_item_id, :total_price, :promo_code, :paid
  json.url order_url(order, format: :json)
end
