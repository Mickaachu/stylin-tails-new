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

ActiveRecord::Schema[8.1].define(version: 2026_09_12_000000) do
  create_table "appointments", force: :cascade do |t|
    t.decimal "cost"
    t.datetime "created_at", null: false
    t.datetime "date_time"
    t.integer "owner_id", null: false
    t.integer "pet_id", null: false
    t.string "service"
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_appointments_on_owner_id"
    t.index ["pet_id"], name: "index_appointments_on_pet_id"
  end

  create_table "availabilities", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.date "available_on", null: false
    t.datetime "created_at", null: false
    t.time "ends_at", null: false
    t.integer "interval_minutes", default: 30, null: false
    t.time "starts_at", null: false
    t.datetime "updated_at", null: false
    t.index ["available_on"], name: "index_availabilities_on_available_on"
  end

  create_table "owners", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "full_name"
    t.string "phone"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_owners_on_user_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "breed"
    t.datetime "created_at", null: false
    t.string "name"
    t.string "notes"
    t.integer "owner_id", null: false
    t.string "size"
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_pets_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "appointments", "owners"
  add_foreign_key "appointments", "pets"
  add_foreign_key "owners", "users"
  add_foreign_key "pets", "owners"
end
