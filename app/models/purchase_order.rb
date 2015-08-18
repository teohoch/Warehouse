class PurchaseOrder < ActiveRecord::Base
  belongs_to :user
  belongs_to :provider
  has_many :item_purchase_orders, :dependent => :delete_all
  accepts_nested_attributes_for :item_purchase_orders, allow_destroy: true

  def article_number
    ItemPurchaseOrder.where(:purchase_order_id => self.id).size
  end
end
