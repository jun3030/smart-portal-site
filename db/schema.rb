# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_11_101612) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "business_trip_ranges", force: :cascade do |t|
    t.integer "masseur_id", null: false
    t.integer "city_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_business_trip_ranges_on_city_id"
    t.index ["masseur_id"], name: "index_business_trip_ranges_on_masseur_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "category_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.integer "prefecture_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["prefecture_id"], name: "index_cities_on_prefecture_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "masseur_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["masseur_id"], name: "index_favorites_on_masseur_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "masseur_categories", force: :cascade do |t|
    t.integer "masseur_id"
    t.integer "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_masseur_categories_on_category_id"
    t.index ["masseur_id"], name: "index_masseur_categories_on_masseur_id"
  end

  create_table "masseurs", force: :cascade do |t|
    t.string "masseur_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "adress"
    t.string "phone_number"
    t.integer "store_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "staff_id"
    t.index ["email"], name: "index_masseurs_on_email", unique: true
    t.index ["reset_password_token"], name: "index_masseurs_on_reset_password_token", unique: true
    t.index ["store_id"], name: "index_masseurs_on_store_id"
  end

  create_table "plan_images", force: :cascade do |t|
    t.json "plan_image"
    t.integer "plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plan_id"], name: "index_plan_images_on_plan_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "plan_name"
    t.string "plan_price"
    t.integer "store_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "plan_content"
    t.integer "plan_time"
    t.integer "course_id"
    t.index ["store_id"], name: "index_plans_on_store_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string "review"
    t.float "rate"
    t.integer "masseur_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["masseur_id"], name: "index_reviews_on_masseur_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "social_profiles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "nickname"
    t.string "email"
    t.string "url"
    t.string "image_url"
    t.string "description"
    t.text "other"
    t.text "credentials"
    t.text "raw_info"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider", "uid"], name: "index_social_profiles_on_provider_and_uid", unique: true
    t.index ["user_id"], name: "index_social_profiles_on_user_id"
  end

  create_table "store_images", force: :cascade do |t|
    t.json "store_image"
    t.integer "store_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["store_id"], name: "index_store_images_on_store_id"
  end

  create_table "store_managers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "smart_token"
    t.integer "order_plan"
    t.index ["email"], name: "index_store_managers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_store_managers_on_reset_password_token", unique: true
  end

  create_table "stores", force: :cascade do |t|
    t.string "store_name", null: false
    t.string "adress"
    t.string "store_phonenumber", null: false
    t.string "store_description"
    t.integer "store_manager_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "calendar_id"
    t.bigint "calendar_secret_id"
    t.integer "calendar_status", default: 0
    t.index ["store_manager_id"], name: "index_stores_on_store_manager_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nickname"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "password"
    t.string "provider"
    t.string "uid"
    t.string "meta"
    t.string "token"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "address"
    t.integer "gender"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "business_trip_ranges", "cities"
  add_foreign_key "business_trip_ranges", "masseurs"
  add_foreign_key "cities", "prefectures"
  add_foreign_key "favorites", "masseurs"
  add_foreign_key "favorites", "users"
  add_foreign_key "masseurs", "stores"
  add_foreign_key "plan_images", "plans"
  add_foreign_key "reviews", "masseurs"
  add_foreign_key "reviews", "users"
  add_foreign_key "social_profiles", "users"
  add_foreign_key "store_images", "stores"
end
