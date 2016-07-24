# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create(
    name: "admin1",
    email: "admin1@test.com",
    password: "password",
    password_confirmation: "password"
)

Admin.create(
    name: "admin2",
    email: "admin2@test.com",
    password: "password",
    password_confirmation: "password"
)