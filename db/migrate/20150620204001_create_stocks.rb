class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.references :articulo, index: true, foreign_key: true, :null => false
      t.integer :quantity, :null => false, :default => 0
      t.references :bodega, index: true, foreign_key: true, :null => false
      t.references :lote, index: true, foreign_key: true, :null => false

      t.timestamps null: false
    end
  end
end
