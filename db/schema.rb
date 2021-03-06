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

ActiveRecord::Schema.define(version: 2021_11_16_094722) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_games", force: :cascade do |t|
    t.bigint "card_id", null: false
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["card_id"], name: "index_card_games_on_card_id"
    t.index ["game_id"], name: "index_card_games_on_game_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "title"
    t.string "category"
    t.integer "calories"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "premium"
    t.integer "price_cents", default: 0, null: false
    t.string "image_path"
  end

  create_table "games", force: :cascade do |t|
    t.string "recipe_title"
    t.string "recipe_content"
    t.string "recipe_comment"
    t.integer "user_rating"
    t.string "objective"
    t.integer "calories"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "saved", default: false
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "state"
    t.integer "amount_cents", default: 0, null: false
    t.string "checkout_session_id"
    t.bigint "user_id", null: false
    t.bigint "card_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["card_id"], name: "index_orders_on_card_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "link"
    t.string "title"
    t.string "duration"
    t.string "difficulty"
    t.string "price"
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "picture"
    t.index ["game_id"], name: "index_recipes_on_game_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "card_games", "cards"
  add_foreign_key "card_games", "games"
  add_foreign_key "games", "users"
  add_foreign_key "orders", "cards"
  add_foreign_key "orders", "users"
  add_foreign_key "recipes", "games"
end
