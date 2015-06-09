class CreateProviderArticles < ActiveRecord::Migration
  def change
    create_table :provider_articles do |t|
      t.references :provider, index: true, foreign_key: true
      t.references :articulo, index: true, foreign_key: true
      t.integer :container_price
      t.integer :unit_price
      t.integer :units_per_container
      t.datetime :validity_date

      t.timestamps null: false
    end
  end
end
