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
    role: "超级管理员",
    company: "中国铁塔公司",
    password: "password",
    password_confirmation: "password",
    admin: true,
    new: false
)

User.create(
    name: "李四",
    company: "中国铁塔分公司1",
    role: "未分配",
    email: "user1@test.com",
    password: "password",
    password_confirmation: "password",
    admin: false,
    new: true
)

User.create(
    name: "王五",
    company: "中国铁塔分公司2",
    role: "未分配",
    email: "user2@test.com",
    password: "password",
    password_confirmation: "password",
    admin: false,
    new: true
)

User.create(
    name: "老六",
    company: "中国铁塔分公司3",
    role: "未分配",
    email: "user3@test.com",
    password: "password",
    password_confirmation: "password",
    admin: false,
    new: true
)

User.create(
    name: "老七",
    company: "中国铁塔分公司3",
    role: "未分配",
    email: "user4@test.com",
    password: "password",
    password_confirmation: "password",
    admin: false,
    new: true
)

User.create(
    name: "老八",
    company: "中国铁塔分公司3",
    role: "未分配",
    email: "user5@test.com",
    password: "password",
    password_confirmation: "password",
    admin: false,
    new: true
)

User.create(
    name: "老九",
    company: "中国铁塔分公司3",
    role: "未分配",
    email: "user6@test.com",
    password: "password",
    password_confirmation: "password",
    admin: false,
    new: true
)


User.create(
    name: "老十",
    company: "中国铁塔分公司3",
    role: "未分配",
    email: "user7@test.com",
    password: "password",
    password_confirmation: "password",
    admin: false,
    new: true
)

