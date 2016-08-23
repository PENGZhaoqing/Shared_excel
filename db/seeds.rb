# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
    name: "张山",
    email: "admin1@test.com",
    company: "中国铁塔公司",
    password: "password",
    password_confirmation: "password",
    admin: true,
)

(1..20).each do |i|
  User.create(
      name: Faker::Name.name,
      company: "中国铁塔公司",
      email: "user#{i}@test.com",
      password: "password",
      password_confirmation: "password",
  )
end

User.create(
    name: "zhaoqing",
    email: "superadmin@test.com",
    company: "开发人员",
    password: "password",
    password_confirmation: "password",
    admin: true,
    hidden: true
)



