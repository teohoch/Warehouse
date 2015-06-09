json.array!(@bodegas) do |bodega|
  json.extract! bodega, :id, :name, :location, :description
  json.url bodega_url(bodega, format: :json)
end
