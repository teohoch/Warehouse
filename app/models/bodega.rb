class Bodega < ActiveRecord::Base
  has_many :stocks
  validates_presence_of :name, :description, :location, :message => I18n.t(:invalid_blank)
end
