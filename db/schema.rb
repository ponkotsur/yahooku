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

ActiveRecord::Schema.define(version: 20160516123050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conditions", force: :cascade do |t|
    t.string "title"
    t.string "sql"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.string   "user_id"
    t.string   "word"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "group_id"
  end

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.integer  "start_price"
    t.integer  "current_price"
    t.integer  "prompt_decision_price"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "exhibitor_name"
    t.integer  "exhibitor_evaluation"
    t.string   "status"
    t.integer  "bit"
    t.string   "auction_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "remaining_time"
    t.string   "remaining_time_unit"
    t.integer  "keyword_id"
  end

  add_index "products", ["id", "auction_id"], name: "index1", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "user_id"
    t.string   "pass"
    t.string   "nickname"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
