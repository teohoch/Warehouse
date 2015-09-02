class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.references :user, index: true, foreign_key: true, :null => false
      t.references :provider, index: true, foreign_key: true, :null => false
      t.date :SubmitDate
      t.integer :TotalAmount, :null => false, :default => 0
      t.string :Status, :null => false, :default => "No Enviada"
      t.string :paymentMethod, :null => false, :default => ""
      t.string :sendLocation, :null => false, :default => ""
      t.date :sendDate, :null => false, :default => Date.today

      t.timestamps null: false
    end
  end
end
