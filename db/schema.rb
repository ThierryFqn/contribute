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

ActiveRecord::Schema.define(version: 2022_02_28_152011) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assos", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_assos_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "cause"
    t.integer "status", default: 0
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.integer "number_volunteers"
    t.bigint "asso_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["asso_id"], name: "index_events_on_asso_id"
  end

  create_table "participations", force: :cascade do |t|
    t.integer "status", default: 0
    t.bigint "event_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_participations_on_event_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "day_birth"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "assos", "users"
  add_foreign_key "events", "assos"
  add_foreign_key "participations", "events"
  add_foreign_key "participations", "users"
end
