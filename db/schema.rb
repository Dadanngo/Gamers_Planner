# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_04_19_050909) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data_centers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_id", null: false
  end

  create_table "event_times", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.datetime "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_times_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "hunter_id"
    t.string "lobby_id"
    t.string "url"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "data_center_id"
    t.bigint "game_id"
    t.index ["data_center_id"], name: "index_events_on_data_center_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.boolean "notify_today"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_notifications_on_event_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "schedule_inputs", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "token", null: false
    t.string "job"
    t.string "comment"
    t.string "player_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "response"
    t.bigint "event_time_id"
    t.index ["event_id"], name: "index_schedule_inputs_on_event_id"
    t.index ["event_time_id"], name: "index_schedule_inputs_on_event_time_id"
    t.index ["token"], name: "index_schedule_inputs_on_token", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "discord_server_id"
    t.string "discord_channel_id"
    t.string "discord_user_id"
    t.string "activation_state"
    t.string "activation_token"
    t.datetime "activation_token_expires_at"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "data_centers", "games"
  add_foreign_key "event_times", "events"
  add_foreign_key "events", "data_centers"
  add_foreign_key "events", "games"
  add_foreign_key "events", "users"
  add_foreign_key "notifications", "events"
  add_foreign_key "notifications", "users"
  add_foreign_key "schedule_inputs", "event_times"
  add_foreign_key "schedule_inputs", "events"
end
