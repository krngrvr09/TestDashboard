json.array!(@items) do |item|
  json.extract! item, :id, :name, :price, :quantity
  json.url item_url(item, format: :json)
end
