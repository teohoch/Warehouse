class RUTValidator < ActiveModel::Validator
  require 'rut_chileno'
  def validate(record)
    unless RUT::validar(record.rut)
      record.errors[:rut] << I18n.t(:invalid_rut)
    end
  end
end

class Provider < ActiveRecord::Base
  resourcify
  has_many :provider_articles
  has_many :current_provider_articles
  has_many :purchase_orders
  validates_presence_of :name, :address, :phone, :rut, :message => I18n.t(:invalid_blank)
  validates_with RUTValidator

  def available_articles
    return CurrentProviderArticle.where(:provider_id =>self.id)
  end
end
