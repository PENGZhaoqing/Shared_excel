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

ActiveRecord::Schema.define(version: 20161105163023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mapping_dbs", force: :cascade do |t|
    t.string   "supplier1"
    t.string   "supplier2"
    t.string   "auth_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mapping_excels", force: :cascade do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "parse",             default: false
  end

  create_table "project_dbs", force: :cascade do |t|
    t.string   "company"
    t.string   "build_way"
    t.string   "project_name"
    t.string   "approve_time"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "project_excels", force: :cascade do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "parse",             default: false
  end

  create_table "repertory_dbs", force: :cascade do |t|
    t.string   "name"
    t.string   "standard"
    t.integer  "num"
    t.string   "supplier"
    t.string   "product_code"
    t.string   "product_kind"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "available"
    t.string   "unit"
    t.string   "model"
  end

  create_table "repertory_excels", force: :cascade do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "parse",             default: false
  end

  create_table "stock_dbs", force: :cascade do |t|
    t.string   "complete_time"
    t.string   "client_name"
    t.string   "product_code"
    t.string   "product_name"
    t.string   "standard"
    t.string   "kind"
    t.string   "supplier"
    t.integer  "export_num"
    t.string   "project_code"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "project_name"
  end

  create_table "stock_excels", force: :cascade do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "parse",             default: false
  end

  create_table "supplier_dbs", force: :cascade do |t|
    t.string   "product"
    t.string   "supplier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supplier_excels", force: :cascade do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "parse",             default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "company"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.boolean  "hidden",          default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
