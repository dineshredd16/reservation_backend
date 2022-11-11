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

ActiveRecord::Schema.define(version: 2022_11_08_155633) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "company_service_id"
    t.datetime "booking_date"
    t.boolean "is_active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_date"], name: "index_bookings_on_booking_date"
    t.index ["company_id"], name: "index_bookings_on_company_id"
    t.index ["company_service_id"], name: "index_bookings_on_company_service_id"
    t.index ["is_active"], name: "index_bookings_on_is_active"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "gstin"
    t.string "pan_no"
    t.string "address"
    t.integer "working_days", default: [], array: true
    t.time "start_time"
    t.time "end_time"
    t.boolean "is_active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_companies_on_code"
    t.index ["is_active"], name: "index_companies_on_is_active"
    
  end

  create_table "company_services", force: :cascade do |t|
    t.string "name"
    t.string "service_code"
    t.bigint "company_id"
    t.integer "time_taken"
    t.float "price"
    t.integer "slots"
    t.boolean "is_active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_services_on_company_id"
    t.index ["is_active"], name: "index_company_services_on_is_active"
    t.index ["service_code"], name: "index_company_services_on_service_code"
    t.index ["slots"], name: "index_company_services_on_slots"
  end

  create_table "user_bookings", force: :cascade do |t|
    t.bigint "booking_id"
    t.bigint "user_id"
    t.integer "payment_reference_id"
    t.boolean "payment_status"
    t.boolean "is_active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_id"], name: "index_user_bookings_on_booking_id"
    t.index ["is_active"], name: "index_user_bookings_on_is_active"
    t.index ["user_id"], name: "index_user_bookings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "mobile_number"
    t.string "email"
    t.boolean "is_active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["is_active"], name: "index_users_on_is_active"
  end

end
