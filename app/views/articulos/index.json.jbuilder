json.array!(@articulos) do |articulo|
  json.extract! articulo, :id, :name, :description, :area
  json.url articulo_url(articulo, format: :json)
end
