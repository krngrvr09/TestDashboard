json.array!(@order_to_items) do |order_to_item|
  json.extract! order_to_item, :id, :order_id, :item_id
  json.url order_to_item_url(order_to_item, format: :json)
end
