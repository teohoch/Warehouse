class Stock < ActiveRecord::Base
  belongs_to :articulo
  belongs_to :bodega
  belongs_to :lote
  validates_presence_of :articulo, :quantity, :bodega, :lote, :message => I18n.t(:invalid_blank)

end
