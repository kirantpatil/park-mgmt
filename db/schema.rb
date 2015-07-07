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

ActiveRecord::Schema.define(version: 20150706101057) do

  create_table "buildings", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ccunits", force: :cascade do |t|
    t.string   "ip"
    t.integer  "port"
    t.integer  "floor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "floors", force: :cascade do |t|
    t.string   "name"
    t.string   "image_url"
    t.integer  "building_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "lots", force: :cascade do |t|
    t.integer  "lotid"
    t.string   "status"
    t.datetime "stime"
    t.datetime "etime"
    t.integer  "zcunit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "zcunits", force: :cascade do |t|
    t.integer  "zcid"
    t.integer  "ccunit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
