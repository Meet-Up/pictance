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

ActiveRecord::Schema.define(version: 20131111163242) do

  create_table "photo_data", force: true do |t|
    t.integer  "user_id"
    t.integer  "photo_id"
    t.float    "x"
    t.float    "y"
    t.float    "smile"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photo_data", ["photo_id"], name: "index_photo_data_on_photo_id"
  add_index "photo_data", ["user_id"], name: "index_photo_data_on_user_id"

  create_table "photos", force: true do |t|
    t.integer  "user_id"
    t.string   "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_url"
  end

  add_index "photos", ["photo_id"], name: "index_photos_on_photo_id"

  create_table "scores", force: true do |t|
    t.string   "user_id"
    t.string   "friend_id"
    t.float    "score",      default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "facebook_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
