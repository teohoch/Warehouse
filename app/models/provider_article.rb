class ProviderArticle < ActiveRecord::Base
  belongs_to :provider
  belongs_to :articulo
  has_many :current_provider_articles

  attr_writer :current_enabled

  def current_enabled
    now = CurrentProviderArticle.where(:articulo_id => self.articulo_id, :provider_id => self.provider_id).limit(1)
    if now.first
      now.first.enabled
    else
      true
    end
  end

end
