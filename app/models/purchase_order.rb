class PurchaseOrder < ActiveRecord::Base
  belongs_to :user
  belongs_to :provider
  has_many :item_purchase_orders
  accepts_nested_attributes_for :item_purchase_orders, allow_destroy: true
end
