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
