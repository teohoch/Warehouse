class Articulo < ActiveRecord::Base
  has_many :provider_articles
  has_many :current_provider_articles
  has_many :stocks
end
