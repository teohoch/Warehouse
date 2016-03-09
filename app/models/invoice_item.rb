class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :provider_article
end
