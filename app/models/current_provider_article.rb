class CurrentProviderArticle < ActiveRecord::Base
  belongs_to :articulo
  belongs_to :provider
  belongs_to :provider_article
  has_many :item_purchase_orders

  def to_label
    return self.articulo.name
  end
end
