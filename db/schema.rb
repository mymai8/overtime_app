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

ActiveRecord::Schema[7.0].define(version: 2024_06_25_104550) do
  create_table "actual_overtime_requests", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "actual_start_time", null: false
    t.datetime "actual_end_time", null: false
    t.integer "break_time", null: false
    t.string "overtime_report", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_actual_overtime_requests_on_user_id"
  end

  create_table "attendances", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "clock_in_at"
    t.datetime "clock_out_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "overtime_requests", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "department", null: false
    t.integer "work_pattern_id", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.text "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_overtime_requests_on_user_id"
    t.index ["work_pattern_id"], name: "index_overtime_requests_on_work_pattern_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role_id", null: false
    t.integer "work_pattern_id", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "actual_overtime_requests", "users"
  add_foreign_key "overtime_requests", "users"
end
