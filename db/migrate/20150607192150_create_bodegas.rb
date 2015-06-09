class CreateBodegas < ActiveRecord::Migration
  def change
    create_table :bodegas do |t|
      t.text :name
      t.text :location
      t.text :description

      t.timestamps null: false
    end
  end
end
