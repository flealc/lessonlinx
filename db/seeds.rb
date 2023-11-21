# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(
  email: "fidel@lessonlinx.pro",
  password: "memememe",
  first_name: "Fidel",
  last_name: "Leal",
  timezone: "Central Time (US & Canada)"
)
