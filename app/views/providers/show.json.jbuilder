json.extract! @provider, :id, :name, :address, :phone, :rut

json.available @provider.available_articles do |item|
  json.current_id item.id
  json.current_name item.articulo.name
  json.container_price item.provider_article.container_price
  json.units_per_container item.provider_article.units_per_container
end
