# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = Category.create([{title: '場地'}, {title: '食物'}, {title: '租車'}, {title: '設備'}, {title: '攝影'}, {title: '印刷'}, {title: '舞台服'}])
regions = Region.create([{title: '北部'}, {title: '中部'}, {title: '南部'}, {title: '東部'}])
activity_kinds = ActivityKind.create([{title: '迎新'}, {title: '宿營'}, {title: '舞會/晚會'}, {title: 'Party'}, {title: '團康'}])
people_numbers = PeopleNumber.create([{title: '1~10'}, {title: '11~20'}, {title: '21~30'}, {title: '31~40'}, {title: '40以上'}])
