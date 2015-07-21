class ItemPurchaseOrder < ActiveRecord::Base
  belongs_to :provider_article
  belongs_to :purchase_order


end
