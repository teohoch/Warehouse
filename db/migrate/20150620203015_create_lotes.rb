class CreateLotes < ActiveRecord::Migration
  def change
    create_table :lotes do |t|
      t.text :description, :null => false
      t.date :expiration_date, :null => false
      t.string :code, :null => false

      t.timestamps null: false
    end
  end
end
