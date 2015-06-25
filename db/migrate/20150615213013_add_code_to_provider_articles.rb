class AddCodeToProviderArticles < ActiveRecord::Migration
  def change
    add_column :provider_articles, :code, :string, :default => "S/Codigo", :null => false
  end
end
