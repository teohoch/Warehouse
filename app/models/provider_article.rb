class ProviderArticle < ActiveRecord::Base
  belongs_to :provider
  belongs_to :articulo
  has_many :current_provider_articles
  has_many :item_purchase_orders

  attr_writer :current_enabled

  validates_presence_of :provider_id, :articulo_id, :validity_date, :message => I18n.t(:invalid_blank)
  validates_presence_of :container_price, :message => "El Precio por Contenedor no puede estar en Blanco."
  validates_presence_of :unit_price, :message => "El Precio por Unidad no puede estar en Blanco."
  validates_presence_of :units_per_container, :message => "El numero de Unidades por Contenedor no puede estar en Blanco."

  def current_enabled
    now = CurrentProviderArticle.where(:articulo_id => self.articulo_id, :provider_id => self.provider_id).limit(1)
    if now.first
      now.first.enabled
    else
      true
    end
  end

  def updated_version
    CurrentProviderArticle.where(:articulo_id => self.articulo_id, :provider_id => self.provider_id).limit(1)[0].provider_article
  end

  def to_label
      self.articulo.name
  end

end
