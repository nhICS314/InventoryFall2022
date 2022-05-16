# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# followed this tutorial https://ninjadevel.com/seeding-database-ruby-on-rails/

Item.destroy_all

Item.create!([{
  name: "White Bread",
  price: 2.99,
  description: "Sandwich sliced bread.",
  count:10,
  sku: "BREADSKU"
},
{
    name: "Whole Milk",
    price: 3.99,
    description: "Half gallon whole milk.",
    count:20,
    sku: "MILKSKU"
},
{
    name: "Eggs",
    price: 2.99,
    description: "12 count omega 3 eggs.",
    count:30,
    sku: "EGGSSKU"
}])

p "Created #{Item.count} items"