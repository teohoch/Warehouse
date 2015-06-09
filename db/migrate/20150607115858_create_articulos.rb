class CreateArticulos < ActiveRecord::Migration
  def change
    create_table :articulos do |t|
      t.text :name
      t.text :description
      t.text :area

      t.timestamps null: false
    end
  end
end
