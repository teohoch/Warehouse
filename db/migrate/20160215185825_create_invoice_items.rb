class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.integer :total_price
      t.integer :amount
      t.integer :unitary_price
      t.references :invoice, index: true, foreign_key: true
      t.references :provider_article, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
