class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :store_name, null: false
      t.string :adress
      t.string :store_phonenumber, null: false
      t.string :store_description
      t.string :payment, default: '店舗にて施術料金をお支払い下さい。'
      t.string :customer_request, default: '・予約のリクエストをいただいた後はメッセージをお送りしておりますので、メッセージ欄をご確認くださいませ。'
      t.string :question, default: 'Q.追加料金がかかる場合がありますか？  A.コースの変更・延長がない場合は施術料の追加料金はかかりません。'
      t.references :store_manager
      t.timestamps
    end
  end
end
