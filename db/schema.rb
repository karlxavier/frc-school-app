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

ActiveRecord::Schema.define(version: 20190627101551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "fee_details", force: :cascade do |t|
    t.integer "fee_id"
    t.date "fee_date"
    t.string "description"
    t.integer "student_id"
    t.decimal "amount", precision: 12, scale: 3
    t.decimal "paid_amount", precision: 12, scale: 3
    t.decimal "balance_amount", precision: 12, scale: 3
    t.integer "payment_type"
    t.string "receipt_no"
    t.string "vno"
    t.decimal "vat_percent", precision: 12, scale: 3
    t.datetime "paid_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "chargeable", default: true
  end

  create_table "fees", force: :cascade do |t|
    t.string "student_id"
    t.decimal "total_amount", precision: 12, scale: 3
    t.decimal "paid_amount", precision: 12, scale: 3
    t.decimal "balance_amount", precision: 12, scale: 3
    t.datetime "last_payment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "fee_rate", precision: 12, scale: 3
    t.boolean "paid", default: false
    t.integer "school_year_id"
    t.datetime "last_notified"
    t.boolean "temp", default: true
  end

  create_table "payment_types", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receipt_details", force: :cascade do |t|
    t.integer "receipt_id"
    t.decimal "amount", precision: 12, scale: 3
    t.integer "fee_detail_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receipts", force: :cascade do |t|
    t.integer "fee_id"
    t.decimal "amount"
    t.integer "receipt_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "payment_type_id"
    t.string "payment_reference"
    t.datetime "receipt_date"
    t.integer "user_id"
    t.string "notes"
  end

  create_table "refunds", force: :cascade do |t|
    t.integer "user_id"
    t.integer "student_id"
    t.integer "fee_id"
    t.decimal "amount"
    t.string "notes"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reminder_details", force: :cascade do |t|
    t.integer "reminder_id"
    t.integer "fee_detail_id"
    t.datetime "fee_date"
    t.string "description"
    t.decimal "amount"
    t.decimal "paid_amount"
    t.decimal "balance_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reminders", force: :cascade do |t|
    t.integer "student_id"
    t.integer "fee_id"
    t.integer "balance_amount"
    t.string "student_name"
    t.string "father_email"
    t.string "student_class"
    t.string "student_division"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "school_years", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "parent_name"
    t.string "status"
    t.string "gender"
    t.string "nationality"
    t.string "birthdate"
    t.string "roll_no"
    t.string "student_class"
    t.string "division"
    t.string "address1"
    t.string "address2"
    t.string "father_mobile"
    t.string "father_email"
    t.string "mother_name"
    t.string "mother_mobile"
    t.string "bus_mode"
    t.string "bus_time_in"
    t.string "bus_time_out"
    t.string "religion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "joining_date"
    t.decimal "rate", precision: 12, scale: 3
    t.boolean "is_active", default: true
  end

  create_table "temp_details", force: :cascade do |t|
    t.string "student_id"
    t.decimal "paid_amount", precision: 12, scale: 3
    t.decimal "balance_amount", precision: 12, scale: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "temp_masters", force: :cascade do |t|
    t.string "student_id"
    t.string "month_year"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin", default: false
    t.boolean "is_guest", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
