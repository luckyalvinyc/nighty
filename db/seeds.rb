# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "\n###"
puts "# Adding users"
puts "#"

User.upsert_all([
  {
    id: 1,
    name: 'lucky'
  },
  {
    id: 2,
    name: 'alvin'
  },
  {
    id: 3,
    name: 'john'
  },
  {
    id: 4,
    name: 'doe'
  }
])

puts "\n###"
puts "# Done adding #{User.count} users"
puts "#"
