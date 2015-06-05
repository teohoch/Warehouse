json.array!(@providers) do |provider|
  json.extract! provider, :id, :name, :address, :phone, :rut
  json.url provider_url(provider, format: :json)
end
