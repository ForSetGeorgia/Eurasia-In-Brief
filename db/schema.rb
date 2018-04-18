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

ActiveRecord::Schema.define(version: 20180418190621) do

  create_table "countries", force: :cascade do |t|
    t.string   "slug",                      limit: 255
    t.datetime "created_at",                                                                   null: false
    t.datetime "updated_at",                                                                   null: false
    t.decimal  "lat",                                   precision: 15, scale: 12
    t.decimal  "lon",                                   precision: 15, scale: 12
    t.integer  "map_zoom_level",            limit: 4,                             default: 13
    t.string   "leader_image_file_name",    limit: 255
    t.string   "leader_image_content_type", limit: 255
    t.integer  "leader_image_file_size",    limit: 4
    t.datetime "leader_image_updated_at"
    t.string   "flag_image_file_name",      limit: 255
    t.string   "flag_image_content_type",   limit: 255
    t.integer  "flag_image_file_size",      limit: 4
    t.datetime "flag_image_updated_at"
    t.string   "freedom_house_index",       limit: 255
    t.integer  "ti_index_score",            limit: 4
    t.integer  "ti_index_rank",             limit: 4
    t.integer  "area",                      limit: 4
    t.integer  "population",                limit: 4
    t.integer  "gdp",                       limit: 4
    t.string   "flag_image2_file_name",     limit: 255
    t.string   "flag_image2_content_type",  limit: 255
    t.integer  "flag_image2_file_size",     limit: 4
    t.datetime "flag_image2_updated_at"
  end

  add_index "countries", ["slug"], name: "index_countries_on_slug", unique: true, using: :btree

  create_table "country_translations", force: :cascade do |t|
    t.integer  "country_id", limit: 4,   null: false
    t.string   "locale",     limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.string   "leader",     limit: 255
  end

  add_index "country_translations", ["country_id"], name: "index_country_translations_on_country_id", using: :btree
  add_index "country_translations", ["locale"], name: "index_country_translations_on_locale", using: :btree
  add_index "country_translations", ["name"], name: "index_country_translations_on_name", using: :btree
  add_index "country_translations", ["slug"], name: "index_country_translations_on_slug", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.string   "locale",         limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["locale"], name: "index_friendly_id_slugs_on_locale", using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type", "locale"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_locale", length: {"slug"=>140, "sluggable_type"=>nil, "locale"=>2}, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope", "locale"], name: "index_friendly_id_slugs_uniqueness", unique: true, length: {"slug"=>70, "sluggable_type"=>nil, "scope"=>70, "locale"=>2}, using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "page_content_translations", force: :cascade do |t|
    t.integer  "page_content_id", limit: 4,     null: false
    t.string   "locale",          limit: 255,   null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "title",           limit: 255
    t.text     "content",         limit: 65535
  end

  add_index "page_content_translations", ["locale"], name: "index_page_content_translations_on_locale", using: :btree
  add_index "page_content_translations", ["page_content_id"], name: "index_page_content_translations_on_page_content_id", using: :btree

  create_table "page_contents", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", force: :cascade do |t|
    t.string   "locale",             limit: 255
    t.text     "content",            limit: 65535
    t.string   "link",               limit: 255
    t.integer  "time_period_id",     limit: 4
    t.integer  "country_id",         limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "title",              limit: 255
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  add_index "stories", ["country_id"], name: "index_stories_on_country_id", using: :btree
  add_index "stories", ["locale"], name: "index_stories_on_locale", using: :btree
  add_index "stories", ["time_period_id"], name: "index_stories_on_time_period_id", using: :btree

  create_table "time_period_translations", force: :cascade do |t|
    t.integer  "time_period_id", limit: 4,   null: false
    t.string   "locale",         limit: 255, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "label",          limit: 255
    t.string   "slug",           limit: 255
  end

  add_index "time_period_translations", ["label"], name: "index_time_period_translations_on_label", using: :btree
  add_index "time_period_translations", ["locale"], name: "index_time_period_translations_on_locale", using: :btree
  add_index "time_period_translations", ["slug"], name: "index_time_period_translations_on_slug", using: :btree
  add_index "time_period_translations", ["time_period_id"], name: "index_time_period_translations_on_time_period_id", using: :btree

  create_table "time_periods", force: :cascade do |t|
    t.string   "slug",         limit: 255
    t.integer  "order",        limit: 4,   default: 1
    t.boolean  "is_published",             default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "time_periods", ["is_published"], name: "index_time_periods_on_is_published", using: :btree
  add_index "time_periods", ["order"], name: "index_time_periods_on_order", using: :btree
  add_index "time_periods", ["slug"], name: "index_time_periods_on_slug", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id",                limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  add_foreign_key "stories", "countries"
  add_foreign_key "stories", "time_periods"
end
