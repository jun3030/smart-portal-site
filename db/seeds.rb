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


# 都道府県データを取得
prefectures = prefectures_api("https://opendata.resas-portal.go.jp/api/v1/prefectures")
# 東京都の市/区データを取得
cities = prefectures_api("https://opendata.resas-portal.go.jp/api/v1/cities?prefCode=13")

prefectures["result"].each do |value|
  prefecture_name = value["prefName"]
  Prefecture.find_or_create_by(name: prefecture_name)
end

cities["result"].each do |value|
  city_name = value["cityName"]
  City.find_or_create_by(name: city_name, prefecture_id: 13)
end
