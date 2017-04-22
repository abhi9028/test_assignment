# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 50.times { |i| Product.create(name: Faker::Commerce.product_name, description: BetterLorem.p(5, false, false), price: 500) }
User.create(email: 'admin@example.com', password: 'admin@123', role: 1)
User.create(email: 'global@logic.com', password: 'global@123', role: 1)