json.extract! @provider, :id, :name, :address, :phone, :rut

json.available @provider.available_articles do |item|
  json.current_id item.id
  json.current_name item.articulo.name
  json.container_price item.container_price
  json.units_per_container item.units_per_container
end
