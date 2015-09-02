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