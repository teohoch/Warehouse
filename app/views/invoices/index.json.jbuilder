json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :provider_id, :num_factura, :user_id, :state, :purchase_order_id, :received_date, :payment_deadline, :payment_date
  json.url invoice_url(invoice, format: :json)
end
