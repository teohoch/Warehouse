class Lote < ActiveRecord::Base
  has_many :stocks
  validates_presence_of :description, :expiration_date, :code, :message => I18n.t(:invalid_blank)
end
