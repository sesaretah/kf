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

ActiveRecord::Schema.define(version: 20181128121847) do

  create_table "businesses", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.integer  "user_id",           limit: 4
    t.string   "tel",               limit: 255
    t.string   "mobile",            limit: 255
    t.string   "fax",               limit: 255
    t.text     "address",           limit: 65535
    t.text     "bio",               limit: 65535
    t.string   "telegram_channel",  limit: 255
    t.string   "instagram_page",    limit: 255
    t.string   "email",             limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "logo_file_name",    limit: 255
    t.string   "logo_content_type", limit: 255
    t.integer  "logo_file_size",    limit: 8
    t.datetime "logo_updated_at"
    t.string   "subdomain",         limit: 255
  end

  create_table "categories", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "parent_id",  limit: 4
    t.integer  "level",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "categorizations", force: :cascade do |t|
    t.integer  "product_id",  limit: 4
    t.integer  "category_id", limit: 4
    t.integer  "level",       limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "classifications", force: :cascade do |t|
    t.integer  "business_id", limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.integer  "category_id", limit: 4
    t.integer  "business_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "surename",            limit: 255
    t.string   "phonenumber",         limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "user_id",             limit: 4
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 8
    t.datetime "avatar_updated_at"
  end

  create_table "specs", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.integer  "category_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
