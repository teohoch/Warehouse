# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

fuser = User.new(:email => "teohoch2@gmail.com",
                 :name => "Teodoro Hochfärber",
                 :location => "1 oriente 215",
                 :password => 'password',
                 :password_confirmation => 'password')
fuser.save
fuser.add_role :admin
fuser.add_role :internal


bodega = Bodega.new(:name => "Principal",
                    :location => "Primer Piso",
                    :description => "Bodega Principal para todo")
bodega.save

proveedor = Provider.new( :name => "Pfizer",
                          :address=> "Santiago, Providencia",
                          :phone => "234234234",
                          :rut => "17995652-7")
proveedor.save

articulo_1 = Articulo.new(:name => "Gasa",
                          :description => "Mantiene las heridas secas",
                          :area => "General")
articulo_1.save


articulo_2 = Articulo.new(:name => "Povidona",
                          :description => "Desinfectante",
                          :area => "General")
articulo_2.save

provider_article_1 = ProviderArticle.new(:provider_id => proveedor.id,
                                         :articulo_id => articulo_1.id,
                                         :container_price => 34,
                                         :unit_price => 1,
                                         :units_per_container => 34,
                                         :validity_date => DateTime.now,
                                         :code => "DFC-23")
provider_article_1.save

current_provider_article_1 = CurrentProviderArticle.new(:articulo_id => provider_article_1.articulo_id,
                                                        :provider_id => provider_article_1.provider_id,
                                                        :provider_article_id => provider_article_1.id,
                                                        :enabled => TRUE)

current_provider_article_1.save


provider_article_2 = ProviderArticle.new(:provider_id => proveedor.id,
                                         :articulo_id => articulo_2.id,
                                         :container_price => 54,
                                         :unit_price => 27,
                                         :units_per_container => 2,
                                         :validity_date => DateTime.now,
                                         :code => "DFC-32")
provider_article_2.save


#current_provider_article_2 = CurrentProviderArticle.new(:articulo_id => provider_article_2.articulo_id, :provider_id => provider_article_2.provider_id,:provider_article_id => provider_article_2.id, :enabled => TRUE)

#current_provider_article_2.save

purchase_order_1 = PurchaseOrder.new(
    :user_id => fuser.id,
    :provider_id => proveedor.id,
    :total_amount => 680,
    :payment_method => "Precio contado",
    :send_location => "1 oriente 215")
purchase_order_1.save

purchase_order_1_item_1 = ItemPurchaseOrder.new(:provider_article_id => provider_article_1.id,
                                 :purchase_order_id => purchase_order_1.id,
                                 :amount => 20,
                                 :container_price => provider_article_1.container_price,
                                 :unit_price => provider_article_1.unit_price,
                                 :units_per_container => provider_article_1.units_per_container,
                                 :total_price => 680)
purchase_order_1_item_1.save

