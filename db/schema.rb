# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150703090550) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "token_secret"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "bootsy_image_galleries", force: :cascade do |t|
    t.integer  "bootsy_resource_id"
    t.string   "bootsy_resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: :cascade do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discounts", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "discount_percentage"
    t.string   "code"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "event_id"
  end

  add_index "discounts", ["event_id"], name: "index_discounts_on_event_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "genre"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "cover_image_file_name"
    t.string   "cover_image_content_type"
    t.integer  "cover_image_file_size"
    t.datetime "cover_image_updated_at"
    t.string   "venue"
    t.integer  "user_id"
    t.integer  "hall_id"
    t.boolean  "free_seating",             default: false
  end

  add_index "events", ["hall_id"], name: "index_events_on_hall_id", using: :btree

  create_table "halls", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "total_seat"
    t.string   "seat_view_file_name"
    t.string   "seat_view_content_type"
    t.integer  "seat_view_file_size"
    t.datetime "seat_view_updated_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "cart_id"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "quantity",                             default: 1
    t.integer  "seat_no",                              default: 0
    t.string   "code"
    t.decimal  "total_price", precision: 12, scale: 3
    t.integer  "payment_id"
  end

  create_table "payments", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.text     "notification_params"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "purchased_at"
    t.integer  "user_id"
    t.string   "currency_type"
    t.decimal  "transaction_amount"
    t.string   "qr_code_file_name"
    t.string   "qr_code_content_type"
    t.integer  "qr_code_file_size"
    t.datetime "qr_code_updated_at"
    t.integer  "cart_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string   "ticket_type"
    t.decimal  "price",       precision: 5, scale: 2
    t.boolean  "free"
    t.integer  "quantity"
    t.integer  "event_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "max_seat_no",                         default: 0
    t.integer  "min_seat_no",                         default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role_id"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "authentications", "users"
  add_foreign_key "discounts", "events"
  add_foreign_key "events", "halls"
end
