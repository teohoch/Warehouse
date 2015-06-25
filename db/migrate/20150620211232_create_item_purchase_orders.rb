class CreateItemPurchaseOrders < ActiveRecord::Migration
  def change
    create_table :item_purchase_orders do |t|
      t.references :current_provider_article, index: true, foreign_key: true, :null => false
      t.references :purchase_order, index: true, foreign_key: true, :null => false
      t.integer :price, :null => false
      t.integer :amount, :null => false

      t.timestamps null: false
    end
  end
end
