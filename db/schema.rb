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

ActiveRecord::Schema.define(version: 20140507015246) do

  create_table "access_tokens", force: true do |t|
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_instances", force: true do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: true do |t|
    t.string   "title"
    t.string   "genre"
    t.string   "isbn"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loans", force: true do |t|
    t.integer  "book_instance_id",                 null: false
    t.integer  "lender_id",                        null: false
    t.integer  "borrower_id",                      null: false
    t.boolean  "approved",         default: false, null: false
    t.boolean  "returned",         default: false, null: false
    t.datetime "requested_at"
    t.datetime "lent_at"
    t.date     "due_on"
    t.datetime "returned_at"
  end

  create_table "reviews", force: true do |t|
    t.integer "book_id"
    t.integer "user_id"
    t.integer "rating"
    t.text    "comments"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "city_state_str"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
