class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :store_name, null: false
      t.string :adress
      t.string :store_phonenumber, null: false
      t.string :store_description
      t.string :payment, default: '店舗にて施術料金をお支払い下さい。'
      t.references :store_manager
      t.timestamps
    end
  end
end
