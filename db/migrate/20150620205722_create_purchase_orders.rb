class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.references :user, index: true, foreign_key: true, :null => false
      t.references :provider, index: true, foreign_key: true, :null => false
      t.date :submit_date
      t.integer :total_amount, :null => false, :default => 0
      t.integer :status, :null => false, :default => 0
      t.string :payment_method, :null => false, :default => ""
      t.string :send_location, :null => false, :default => ""
      t.date :send_date

      t.timestamps null: false
    end
  end
end
