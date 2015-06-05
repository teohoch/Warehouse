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
  validates_presence_of :name, :address, :phone, :rut, :message => I18n.t(:invalid_blank)
  validates_with RUTValidator
end
