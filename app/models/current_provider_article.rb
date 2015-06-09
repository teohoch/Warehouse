class CurrentProviderArticle < ActiveRecord::Base
  belongs_to :articulo
  belongs_to :provider
  belongs_to :provider_article
end
