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

ActiveRecord::Schema.define(version: 20131203050152) do

  create_table "books", force: true do |t|
    t.string   "name"
    t.string   "subject"
    t.string   "author"
    t.string   "edition"
    t.decimal  "price"
    t.string   "googleId"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "isbn"
    t.string   "published"
    t.text     "description"
  end

  create_table "conditions", force: true do |t|
    t.string   "description"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventory_haves", force: true do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.string   "condition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventory_needs", force: true do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventory_owns", force: true do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "condition_id"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "image"
    t.string   "icon"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trade_lines", force: true do |t|
    t.boolean  "user_from_accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "trade_id"
    t.integer  "inventory_own_id"
    t.integer  "inventory_need_id"
  end

  create_table "trade_notes", force: true do |t|
    t.integer  "trade_id"
    t.text     "meet_time"
    t.string   "place"
    t.text     "comment"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  create_table "trades", force: true do |t|
    t.integer  "status",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id"
  end

  create_table "user_feedbacks", force: true do |t|
    t.integer  "user_from_id"
    t.integer  "user_to_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "trade_id"
    t.integer  "score"
  end

  create_table "user_locations", force: true do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_schedules", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "from"
    t.integer  "to"
    t.string   "day"
    t.integer  "user_location_id"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "passhash"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activated"
    t.string   "salt"
    t.string   "first"
    t.string   "last"
    t.string   "token"
    t.string   "timezone"
  end

end
