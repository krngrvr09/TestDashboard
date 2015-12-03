json.array!(@user_to_items) do |user_to_item|
  json.extract! user_to_item, :id, :user_id, :item_id
  json.url user_to_item_url(user_to_item, format: :json)
end
