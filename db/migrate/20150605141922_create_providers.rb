class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.text :name
      t.text :address
      t.text :phone
      t.string :rut

      t.timestamps null: false
    end
  end
end
