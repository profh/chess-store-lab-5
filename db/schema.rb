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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110506134535) do

  create_table "categories", :force => true do |t|
    t.string   "session_id"
    t.string   "name"
    t.string   "code"
    t.integer  "display_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["code"], :name => "index_categories_on_code"
  add_index "categories", ["session_id"], :name => "index_categories_on_session_id"

  create_table "categories_products", :id => false, :force => true do |t|
    t.string  "session_id"
    t.integer "category_id"
    t.integer "product_id"
  end

  add_index "categories_products", ["category_id"], :name => "index_categories_products_on_category_id"
  add_index "categories_products", ["product_id"], :name => "index_categories_products_on_product_id"
  add_index "categories_products", ["session_id"], :name => "index_categories_products_on_session_id"

  create_table "mailing_lists", :force => true do |t|
    t.string   "session_id"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mailing_lists", ["email"], :name => "index_mailing_lists_on_email"
  add_index "mailing_lists", ["session_id"], :name => "index_mailing_lists_on_session_id"

  create_table "order_line_items", :force => true do |t|
    t.string   "session_id"
    t.integer  "order_id"
    t.integer  "product_id"
    t.float    "price"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_line_items", ["order_id"], :name => "index_order_line_items_on_order_id"
  add_index "order_line_items", ["product_id"], :name => "index_order_line_items_on_product_id"
  add_index "order_line_items", ["session_id"], :name => "index_order_line_items_on_session_id"

  create_table "orders", :force => true do |t|
    t.string   "session_id"
    t.integer  "user_id"
    t.float    "sub_total"
    t.float    "tax"
    t.float    "total"
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["billing_address_id"], :name => "index_orders_on_billing_address_id"
  add_index "orders", ["session_id"], :name => "index_orders_on_session_id"
  add_index "orders", ["shipping_address_id"], :name => "index_orders_on_shipping_address_id"
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "products", :force => true do |t|
    t.string   "session_id"
    t.string   "upc"
    t.string   "name"
    t.string   "image"
    t.text     "description"
    t.decimal  "price"
    t.boolean  "is_active",   :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["session_id"], :name => "index_products_on_session_id"
  add_index "products", ["upc"], :name => "index_products_on_upc"

  create_table "reviews", :force => true do |t|
    t.string   "session_id"
    t.integer  "product_id"
    t.integer  "user_id"
    t.text     "review"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["product_id"], :name => "index_reviews_on_product_id"
  add_index "reviews", ["session_id"], :name => "index_reviews_on_session_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "session_id"
    t.string   "username"
    t.string   "password"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "race"
    t.string   "registration_key"
    t.boolean  "is_admin",         :default => false
    t.boolean  "is_active",        :default => false
    t.string   "changer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["registration_key"], :name => "index_users_on_registration_key"
  add_index "users", ["session_id"], :name => "index_users_on_session_id"
  add_index "users", ["username"], :name => "index_users_on_username"

end
