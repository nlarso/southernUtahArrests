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

ActiveRecord::Schema.define(version: 20150920195553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "arrests", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "pcf_number"
    t.string   "arrested_by"
    t.string   "agency"
    t.datetime "arrested_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "external_mugshot_url"
    t.string   "mugshot"
  end

  create_table "charge_types", force: :cascade do |t|
    t.string   "name"
    t.string   "statute"
    t.string   "classification"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "charges", force: :cascade do |t|
    t.integer  "arrest_id"
    t.integer  "charge_type_id"
    t.string   "name"
    t.string   "statute"
    t.string   "classification"
    t.integer  "required_bond"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "charges", ["arrest_id"], name: "index_charges_on_arrest_id", using: :btree
  add_index "charges", ["charge_type_id"], name: "index_charges_on_charge_type_id", using: :btree

  add_foreign_key "charges", "arrests"
  add_foreign_key "charges", "charge_types"
end
