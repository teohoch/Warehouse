class ItemPurchaseOrder < ActiveRecord::Base
  belongs_to :current_provider_article
  belongs_to :purchase_order
end
