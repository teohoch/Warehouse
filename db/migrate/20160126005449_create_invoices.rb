class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :provider, index: true, foreign_key: true
      t.string :num_factura
      t.references :user, index: true, foreign_key: true
      t.string :state
      t.references :purchase_order, index: true, foreign_key: true
      t.date :received_date
      #TODO set default :received_date to current date


      t.timestamps null: false
    end
  end
end
