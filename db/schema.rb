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

ActiveRecord::Schema.define(version: 20150608174757) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articulos", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.text     "area"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "bodegas", force: :cascade do |t|
    t.text     "name"
    t.text     "location"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "current_provider_articles", force: :cascade do |t|
    t.integer  "articulo_id",         null: false
    t.integer  "provider_id",         null: false
    t.integer  "provider_article_id", null: false
    t.boolean  "enabled"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "current_provider_articles", ["articulo_id"], name: "index_current_provider_articles_on_articulo_id", using: :btree
  add_index "current_provider_articles", ["provider_article_id"], name: "index_current_provider_articles_on_provider_article_id", using: :btree
  add_index "current_provider_articles", ["provider_id"], name: "index_current_provider_articles_on_provider_id", using: :btree

  create_table "provider_articles", force: :cascade do |t|
    t.integer  "provider_id"
    t.integer  "articulo_id"
    t.integer  "container_price"
    t.integer  "unit_price"
    t.integer  "units_per_container"
    t.datetime "validity_date"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "provider_articles", ["articulo_id"], name: "index_provider_articles_on_articulo_id", using: :btree
  add_index "provider_articles", ["provider_id"], name: "index_provider_articles_on_provider_id", using: :btree

  create_table "providers", force: :cascade do |t|
    t.text     "name"
    t.text     "address"
    t.text     "phone"
    t.string   "rut"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  add_foreign_key "current_provider_articles", "articulos"
  add_foreign_key "current_provider_articles", "provider_articles"
  add_foreign_key "current_provider_articles", "providers"
  add_foreign_key "provider_articles", "articulos"
  add_foreign_key "provider_articles", "providers"
end
