# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
include StoreManager::BusinessTripRangesHelper

Admin.create!(email: "admin@email.com",
             password: "password",
             password_confirmation: "password"
            )

User.create!(name: "tester",
            email: "tester@email.com",
            address: "japan-aichi-nagoya",
            password: "password",
            password_confirmation: "password",
            nickname: "tester",
            gender: "male"
           )

StoreManager.create!(email: "store_manager@email.com",
                    name: "store_manager",
                    password: "password"
                   )


Store.create!(store_name: "abc_store",
            adress: "japan-aichi-nagoya",
            store_phonenumber: "08012345678",
            store_description: SecureRandom.alphanumeric(120),
            store_manager_id: 1
          )

Masseur.create!(masseur_name: "cororo",
               email: "cororo@email.com",
               adress: "japan-aichi-nagoya",
               password: "password",
               password_confirmation: "password",
               store_id: 1
              )

Favorite.create!(user_id: 1,
                masseur_id: 1
               )

Review.create!(review: "so good",
               rate: 3.5,
               user_id: 1,
               masseur_id: 1
               )
            
5.times do |n|
  Plan.create!(plan_name: "プラン#{n+1}",
               plan_content: "PCやスマートフォンを使ったり鞄を持ったりと、日常の疲れが溜まりやすい肘から下をもみほぐす【ハンドリフレ】。肩や目が疲れやすい方に、頭から首にかけてもみほぐす【クイックヘッド】。ストレスが溜まりやすい方や頭からスッキリとリラックスしたい方にオススメ。",
               plan_time: 100,
               plan_price: 4500,
               store_id: 1)
end

# 実際にカテゴリとして使用するデータ
Category.create!(category_name: "整体")
Category.create!(category_name: "骨格矯正")
Category.create!(category_name: "ストレッチ")
Category.create!(category_name: "アロマセラピー")
Category.create!(category_name: "指圧")
Category.create!(category_name: "按摩")
Category.create!(category_name: "鍼灸")
Category.create!(category_name: "スポーツマッサージ")
Category.create!(category_name: "足つぼマッサージ")
Category.create!(category_name: "オイルマッサージ")
Category.create!(category_name: "その他")

MasseurCategory.create!(masseur_id: 1, category_id: 1)

# 日本/地方データ
Region.create!(area: "北海道")
Region.create!(area: "東北")
Region.create!(area: "関東")
Region.create!(area: "中部")
Region.create!(area: "近畿")
Region.create!(area: "中国")
Region.create!(area: "四国")
Region.create!(area: "九州・沖縄")

# 日本の地域区分
area_1 = ["北海道"]
area_2 = ["青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県"]
area_3 = ["茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県"]
area_4 = ["新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県", "愛知県"]
area_5 = ["三重県", "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県"]
area_6 = ["鳥取県", "島根県", "岡山県", "広島県", "山口県"]
area_7 = ["徳島県", "香川県", "愛媛県", "高知県"]
area_8 = ["福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"]

area_1.each {|value| Prefecture.find_or_create_by(name: value, region_id: 1)}
area_2.each {|value| Prefecture.find_or_create_by(name: value, region_id: 2)}
area_3.each {|value| Prefecture.find_or_create_by(name: value, region_id: 3)}
area_4.each {|value| Prefecture.find_or_create_by(name: value, region_id: 4)}
area_5.each {|value| Prefecture.find_or_create_by(name: value, region_id: 5)}
area_6.each {|value| Prefecture.find_or_create_by(name: value, region_id: 6)}
area_7.each {|value| Prefecture.find_or_create_by(name: value, region_id: 7)}
area_8.each {|value| Prefecture.find_or_create_by(name: value, region_id: 8)}

# 都道府県データを取得
# prefectures = prefectures_api("https://opendata.resas-portal.go.jp/api/v1/prefectures")

# prefectures["result"].each do |value|
#   prefecture_name = value["prefName"]
#   Prefecture.find_or_create_by(name: prefecture_name)
# end

# 東京都の市/区データを取得
cities = prefectures_api("https://opendata.resas-portal.go.jp/api/v1/cities?prefCode=13")

cities["result"].each do |value|
  city_name = value["cityName"]
  City.find_or_create_by(name: city_name, prefecture_id: 13)
end
