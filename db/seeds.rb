# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
    name: "管理员1",
    email: "admin1@test.com",
    company: "中国铁塔公司",
    password: "password",
    password_confirmation: "password",
    admin: true,
)

MAP={
    cy: '朝阳',
    tz: '通州',
    cb: '城北',
    cx: '城西',
    zxcq: '中心城区',
    hr: '怀柔',
    pg: '平谷'
    my: '密云',
    yq: '延庆',
    sy: '顺义',
    dx: '大兴',
    fs: '房山',
    cp: '昌平',
}

MAP.each do |item|
  User.create!(
      name: "#{item[1]}分公司",
      company: "#{item[1]}分公司",
      email: "#{item[0]}@chinatowercom.cn",
      password: item[0],
      password_confirmation: item[0]
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



