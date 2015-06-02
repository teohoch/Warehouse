class CreateBodegas < ActiveRecord::Migration
  def change
    create_table :bodegas do |t|
      t.string :name
      t.text :ubicacion
      t.text :descripcion

      t.timestamps null: false
    end
  end
end
