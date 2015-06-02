json.array!(@bodegas) do |bodega|
  json.extract! bodega, :id, :name, :ubicacion, :descripcion
  json.url bodega_url(bodega, format: :json)
end
