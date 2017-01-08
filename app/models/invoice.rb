class Invoice < ActiveRecord::Base
  belongs_to :provider
  belongs_to :user
  belongs_to :purchase_order
  has_many :invoice_items
  has_many :payments

  accepts_nested_attributes_for :invoice_items, allow_destroy: true
  accepts_nested_attributes_for :payments, allow_destroy: true
end
