json.array!(@productos) do |producto|
  json.extract! producto, :id, :name, :price
  json.url producto_url(producto, format: :json)
end
