json.array!(@purchase_orders) do |purchase_order|
  json.extract! purchase_order, :id, :user_id, :provider_id, :SubmitDate, :TotalAmount
  json.url purchase_order_url(purchase_order, format: :json)
end
