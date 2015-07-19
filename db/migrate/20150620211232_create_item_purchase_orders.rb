class CreateItemPurchaseOrders < ActiveRecord::Migration
  def change
    create_table :item_purchase_orders do |t|
      t.references :current_provider_article, index: true, foreign_key: true, :null => false
      t.references :purchase_order, index: true, foreign_key: true, :null => false
      t.integer :amount, :null => false
      t.integer :container_price, :null => false
      t.integer :unit_price, :null => false
      t.integer :units_per_container, :null => false
      t.integer :total_price, :null => false
      t.timestamps null: false
    end
  end
end
