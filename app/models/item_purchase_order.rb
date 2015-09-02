class ItemPurchaseOrder < ActiveRecord::Base
  belongs_to :provider_article
  belongs_to :purchase_order

  def current_version_id
    #The most Updated version of this Provider_article
    self.provider_article.updated_version.id
  end
end
