class CreateCurrentProviderArticles < ActiveRecord::Migration
  def change
    create_table :current_provider_articles do |t|
      t.references :articulo, index: true, foreign_key: true, :null => false
      t.references :provider, index: true, foreign_key: true, :null => false
      t.references :provider_article, index: true, foreign_key: true, :null => false
      t.boolean :enabled

      t.timestamps null: false
    end
  end
end
