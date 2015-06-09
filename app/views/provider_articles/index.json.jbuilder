json.array!(@provider_articles) do |provider_article|
  json.extract! provider_article, :id, :provider_id, :articulo_id, :container_price, :unit_price, :units_per_container, :validity_date
  json.url provider_article_url(provider_article, format: :json)
end
