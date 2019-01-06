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

ActiveRecord::Schema.define(version: 20190106124919) do

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
    t.integer  "theme_id",          limit: 4
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "cart_id",    limit: 4
    t.integer  "product_id", limit: 4
    t.integer  "quantity",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "faqs", force: :cascade do |t|
    t.text     "question",    limit: 65535
    t.text     "answer",      limit: 65535
    t.integer  "rank",        limit: 4
    t.integer  "business_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "likeable_id",   limit: 4
    t.string   "likeable_type", limit: 255
    t.integer  "user_id",       limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "product_id",   limit: 4
    t.integer  "order_id",     limit: 4
    t.string   "unit_price",   limit: 255
    t.integer  "quantity",     limit: 4
    t.integer  "total_price",  limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "product_name", limit: 255
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "subtotal",             limit: 255
    t.string   "tax",                  limit: 255
    t.string   "shipping",             limit: 255
    t.string   "total",                limit: 255
    t.integer  "business_id",          limit: 4
    t.integer  "user_id",              limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "customer_name",        limit: 255
    t.string   "customer_mobile",      limit: 255
    t.string   "customer_province",    limit: 255
    t.string   "customer_address",     limit: 255
    t.string   "customer_postal_code", limit: 255
    t.string   "reciever_province",    limit: 255
    t.string   "reciever_address",     limit: 255
    t.string   "reciever_postal_code", limit: 255
    t.integer  "order_status_id",      limit: 4
    t.string   "reciever_name",        limit: 255
    t.string   "reciever_mobile",      limit: 255
    t.string   "uuid",                 limit: 255
  end

  add_index "orders", ["uuid"], name: "index_orders_on_uuid", using: :btree

  create_table "pixels", force: :cascade do |t|
    t.integer  "category_id", limit: 4
    t.string   "title",       limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "business_id", limit: 4
  end

  create_table "products", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.text     "description",     limit: 65535
    t.integer  "category_id",     limit: 4
    t.integer  "business_id",     limit: 4
    t.integer  "user_id",         limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "price",           limit: 255
    t.string   "currency",        limit: 255
    t.string   "brand",           limit: 255
    t.integer  "order_status_id", limit: 4
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "surename",            limit: 255
    t.string   "phonenumber",         limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "user_id",             limit: 4
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 8
    t.datetime "avatar_updated_at"
    t.text     "address",             limit: 65535
    t.integer  "province_id",         limit: 4
    t.string   "postal_code",         limit: 255
  end

  create_table "prominents", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "level",      limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "provinces", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sale_settings", force: :cascade do |t|
    t.boolean  "shipping_cost"
    t.boolean  "vat"
    t.boolean  "force_signin"
    t.integer  "business_id",   limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "segmentations", force: :cascade do |t|
    t.integer  "segment_id", limit: 4
    t.integer  "product_id", limit: 4
    t.string   "ext_code",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "segments", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "business_id",      limit: 4
    t.string   "ext_code",         limit: 255
    t.boolean  "view_in_homepage"
    t.integer  "level",            limit: 4
  end

  create_table "shipping_costs", force: :cascade do |t|
    t.integer  "province_id", limit: 4
    t.integer  "business_id", limit: 4
    t.string   "cost",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "specifications", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "spec_id",    limit: 4
    t.string   "spec_value", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "specs", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.integer  "category_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "taxations", force: :cascade do |t|
    t.decimal  "percent",               precision: 10
    t.integer  "business_id", limit: 4
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "themes", force: :cascade do |t|
    t.string   "header_background",          limit: 255
    t.string   "navtab_color",               limit: 255
    t.string   "footer_background",          limit: 255
    t.string   "footer_color",               limit: 255
    t.string   "body_background_color",      limit: 255
    t.string   "list_group_item_background", limit: 255
    t.string   "list_group_item_color",      limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "title",                      limit: 255
    t.string   "header_border_bottom",       limit: 255
  end

  create_table "uploads", force: :cascade do |t|
    t.string   "uploadable_type",         limit: 255
    t.integer  "uploadable_id",           limit: 4
    t.string   "attachment_type",         limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size",    limit: 8
    t.datetime "attachment_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "mobile",                 limit: 255
    t.string   "username",               limit: 255
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "visits", force: :cascade do |t|
    t.integer  "visitable_id",    limit: 4
    t.string   "visitable_type",  limit: 255
    t.text     "visitor_session", limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

end
