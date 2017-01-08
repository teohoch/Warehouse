class PurchaseOrder < ActiveRecord::Base
  belongs_to :user
  belongs_to :provider
  has_many :item_purchase_orders, :dependent => :delete_all
  has_many :invoices
  accepts_nested_attributes_for :item_purchase_orders, allow_destroy: true

  def article_number
    ItemPurchaseOrder.where(:purchase_order_id => self.id).size
  end

  def status_human
    case self.status
      when 0
        I18n.t("not_sent")
      when 1
        I18n.t("sent")
    end
  end

  def editable
    self.status == 0
  end
end
