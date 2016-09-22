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
    chaoyang: '朝阳',
    tongzhou: '通州',
    chengbei: '城北',
    chengxi: '城西',
    zhongxinchengqu: '中心城区',
    huairou: '怀柔',
    pinggu: '密云',
    yanqing: '延庆',
    shunyi: '顺义',
    daxing: '大兴',
    fangshan: '房山',
    changping: '昌平',
}

MAP.each do |item|
  User.create!(
      name: "#{item[1]}分公司",
      company: "#{item[1]}分公司",
      email: "#{item[0]}@qq.com",
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



