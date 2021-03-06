# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_11_17_085038) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activity_kinds", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activity_kinds_products", id: false, force: :cascade do |t|
    t.bigint "activity_kind_id", null: false
    t.bigint "product_id", null: false
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer "user_id"
    t.integer "cart_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.integer "product_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rating", default: 0
    t.json "images"
  end

  create_table "gmaps", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.string "address"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identities", force: :cascade do |t|
    t.integer "user_id"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "matter_forms", force: :cascade do |t|
    t.string "email"
    t.string "school"
    t.datetime "date"
    t.integer "people"
    t.integer "vegetarian"
    t.integer "non_vegetarian"
    t.text "expect_menu"
    t.integer "budget"
    t.string "activity_location"
    t.text "device"
    t.text "material"
    t.text "size"
    t.json "images"
    t.text "memo"
    t.integer "user_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matters", force: :cascade do |t|
    t.text "mattertext"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.json "images"
    t.integer "user_id"
    t.integer "product_id"
  end

  create_table "people_numbers", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "item"
    t.text "limit"
    t.text "activity"
    t.string "location"
    t.string "tel"
    t.string "email"
    t.string "url"
    t.text "equipment"
    t.integer "category_id"
    t.integer "region_id"
    t.integer "activity_kind_id"
    t.integer "people_number_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "images"
    t.json "budget_images"
    t.string "budget"
    t.string "budget_option"
    t.integer "min_price"
    t.index ["activity_kind_id"], name: "index_products_on_activity_kind_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["people_number_id"], name: "index_products_on_people_number_id"
    t.index ["region_id"], name: "index_products_on_region_id"
  end

  create_table "products_regions", id: false, force: :cascade do |t|
    t.bigint "region_id", null: false
    t.bigint "product_id", null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "user"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
