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

5.times do |n|
User.create!(name: "tester#{n+1}",
            email: "tester#{n+1}@email.com",
            address: "japan-aichi-nagoya",
            password: "password",
            password_confirmation: "password",
            nickname: "tester",
            gender: "male"
           )
end

StoreManager.create!(email: "store_manager@email.com",
                    name: "store_manager",
                    password: "password"
                   )


Store.create!(store_name: "abc_store",
            adress: "japan-aichi-nagoya",
            store_phonenumber: "08012345678",
            store_description:  SecureRandom.alphanumeric(120),
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
MasseurCategory.create!(masseur_id: 1, category_id: 2)



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

# 市/区データを取得/今のところ関東地域のみ取得
# cities_8 = prefectures_api("https://opendata.resas-portal.go.jp/api/v1/cities?prefCode=8")
# cities_9 = prefectures_api("https://opendata.resas-portal.go.jp/api/v1/cities?prefCode=9")
# cities_10 = prefectures_api("https://opendata.resas-portal.go.jp/api/v1/cities?prefCode=10")
# cities_11 = prefectures_api("https://opendata.resas-portal.go.jp/api/v1/cities?prefCode=11")
cities_12 = prefectures_api("https://opendata.resas-portal.go.jp/api/v1/cities?prefCode=12")
cities_13 = prefectures_api("https://opendata.resas-portal.go.jp/api/v1/cities?prefCode=13")
cities_14 = prefectures_api("https://opendata.resas-portal.go.jp/api/v1/cities?prefCode=14")

# 都道府県に紐づく市/区データを作成/今のところ関東地域のみ作成
# cities_8["result"].each {|value| City.find_or_create_by(name: value["cityName"], prefecture_id: 8)}
# cities_9["result"].each {|value| City.find_or_create_by(name: value["cityName"], prefecture_id: 9)}
# cities_10["result"].each {|value| City.find_or_create_by(name: value["cityName"], prefecture_id: 10)}
# cities_11["result"].each {|value| City.find_or_create_by(name: value["cityName"], prefecture_id: 11)}
cities_12["result"].each {|value| City.find_or_create_by(name: value["cityName"], prefecture_id: 12)}
cities_13["result"].each {|value| City.find_or_create_by(name: value["cityName"], prefecture_id: 13)}
cities_14["result"].each {|value| City.find_or_create_by(name: value["cityName"], prefecture_id: 14)}

StoreManager.create!(email: "sample1@email.com",
                    name: "sample1",
                    password: "password",
                    order_plan: 1
                    )

StoreManager.create!(email: "sample2@email.com",
                    name: "sample2",
                    password: "password",
                    order_plan: 1
                    )

Store.create!(store_name: "sample1の店舗",
              adress: "京都府京都市中京区",
              store_phonenumber: "09012345678",
              store_description: "sample1の店舗sample1の店舗sample1の店舗",
              store_manager_id: 2,
              calendar_id: 2,
              calendar_secret_id: 2,
              calendar_status: "released"
              )

Store.create!(store_name: "sample2の店舗",
              adress: "京都府京都市中京区",
              store_phonenumber: "09012345678",
              store_description: "sample2の店舗sample2の店舗sample2の店舗",
              store_manager_id: 3,
              calendar_id: 3,
              calendar_secret_id: 3,
              calendar_status: "released"
              )

Masseur.create!(masseur_name: "sample1",
                email: "sample1@email.com",
                adress: "京都府京都市中京区",
                password: "password",
                password_confirmation: "password",
                store_id: 2
                )

Masseur.create!(masseur_name: "sample2",
                email: "sample2@email.com",
                adress: "京都府京都市中京区",
                password: "password",
                password_confirmation: "password",
                store_id: 3
                )

5.times do |n|
  Plan.create!(plan_name: "プラン#{n+1}",
                plan_content: "PCやスマートフォンを使ったり鞄を持ったりと、日常の疲れが溜まりやすい肘から下をもみほぐす【ハンドリフレ】。肩や目が疲れやすい方に、頭から首にかけてもみほぐす【クイックヘッド】。ストレスが溜まりやすい方や頭からスッキリとリラックスしたい方にオススメ。",
                plan_time: "#{n+1}0",
                plan_price: "#{n+1}500",
                store_id: 2)
end

5.times do |n|
  Plan.create!(plan_name: "プラン#{n+1}",
                plan_content: "PCやスマートフォンを使ったり鞄を持ったりと、日常の疲れが溜まりやすい肘から下をもみほぐす【ハンドリフレ】。肩や目が疲れやすい方に、頭から首にかけてもみほぐす【クイックヘッド】。ストレスが溜まりやすい方や頭からスッキリとリラックスしたい方にオススメ。",
                plan_time: "#{n+1}0",
                plan_price: "#{n+1}500",
                store_id: 3)
end

Review.create!(user_id: 1, store_id: 2, content: "まあまあ", rate: 5.0, title: "最高でした")
Review.create!(user_id: 1, store_id: 3, content: "よかった", rate: 4.0, title: "良い良い")
Review.create!(user_id: 2, store_id: 2, content: "また利用したいです", rate: 4.0, title: "気楽に頼めた")
Review.create!(user_id: 2, store_id: 3, content: "まあまあ", rate: 5.0, title: "最高でした")
Review.create!(user_id: 3, store_id: 2, content: "次も利用します", rate: 4.0, title: "安心して利用できました")
Review.create!(user_id: 3, store_id: 3, content: "次も利用します", rate: 5.0, title: "安心して利用できました")
