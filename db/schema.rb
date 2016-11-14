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

ActiveRecord::Schema.define(version: 20161114165334) do

  create_table "assigned_permissions", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "permission_id", limit: 4
    t.integer  "value",         limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "assigned_permissions", ["permission_id"], name: "fk_rails_aca282a7fd", using: :btree
  add_index "assigned_permissions", ["user_id"], name: "fk_rails_324ef26984", using: :btree

  create_table "attachments", force: :cascade do |t|
    t.integer  "attachable_id",   limit: 4
    t.string   "attachable_type", limit: 255
    t.string   "content_type",    limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "file",            limit: 255
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "parent_id",      limit: 4
    t.integer  "lft",            limit: 4,               null: false
    t.integer  "rgt",            limit: 4,               null: false
    t.integer  "depth",          limit: 4,   default: 0, null: false
    t.integer  "children_count", limit: 4,   default: 0, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "position",       limit: 4
  end

  add_index "categories", ["lft"], name: "index_categories_on_lft", using: :btree
  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id", using: :btree
  add_index "categories", ["rgt"], name: "index_categories_on_rgt", using: :btree

  create_table "categories_documents", id: false, force: :cascade do |t|
    t.integer "document_id", limit: 4
    t.integer "category_id", limit: 4
  end

  add_index "categories_documents", ["category_id"], name: "index_categories_documents_on_category_id", using: :btree
  add_index "categories_documents", ["document_id"], name: "index_categories_documents_on_document_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.integer  "added_by",            limit: 4
    t.string   "name",                limit: 255
    t.boolean  "is_valid"
    t.string   "content_type",        limit: 255
    t.string   "file",                limit: 255
    t.string   "google_url",          limit: 255
    t.string   "google_id",           limit: 255
    t.text     "google_contents",     limit: 65535
    t.datetime "google_updated_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.date     "document_updated_on"
  end

  create_table "employee_notes", force: :cascade do |t|
    t.integer  "employee",     limit: 4
    t.integer  "entered_by",   limit: 4
    t.date     "note_on"
    t.string   "note_type",    limit: 255
    t.string   "ip_address",   limit: 255
    t.text     "notes",        limit: 65535
    t.text     "follow_up",    limit: 65535
    t.date     "follow_up_on"
    t.string   "external_key", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "employee_notes", ["employee"], name: "fk_rails_a688637a0d", using: :btree
  add_index "employee_notes", ["entered_by"], name: "fk_rails_60f15ac792", using: :btree

  create_table "opto_messages", force: :cascade do |t|
    t.string   "message_name", limit: 255
    t.datetime "message_at"
    t.integer  "department",   limit: 4
    t.integer  "lane",         limit: 4
    t.integer  "station",      limit: 4
    t.integer  "shop_order",   limit: 4
    t.integer  "load",         limit: 4
    t.integer  "barrel",       limit: 4
    t.string   "customer",     limit: 255
    t.text     "message",      limit: 65535
    t.string   "hashed_data",  limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "raw_data",     limit: 65535
  end

  add_index "opto_messages", ["hashed_data"], name: "index_opto_messages_on_hash", unique: true, using: :btree

  create_table "permissions", force: :cascade do |t|
    t.string  "permission",  limit: 255
    t.string  "description", limit: 255
    t.integer "label_set",   limit: 4
  end

  add_index "permissions", ["permission"], name: "index_permissions_on_permission", unique: true, using: :btree

  create_table "shift_notes", force: :cascade do |t|
    t.integer  "entered_by",          limit: 4
    t.date     "note_on"
    t.integer  "shift",               limit: 4
    t.string   "ip_address",          limit: 255
    t.integer  "department",          limit: 4
    t.string   "note_type",           limit: 255
    t.text     "notes",               limit: 65535
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "supervisor_notes",    limit: 65535
    t.datetime "supervisor_notes_at"
    t.integer  "supervisor_id",       limit: 4
    t.boolean  "author_email_needed"
  end

  add_index "shift_notes", ["entered_by"], name: "fk_rails_8c4d173e86", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",         limit: 255
    t.integer  "employee_number",  limit: 4
    t.string   "first_name",       limit: 255
    t.string   "last_name",        limit: 255
    t.string   "suffix",           limit: 255
    t.string   "initials",         limit: 255
    t.string   "email",            limit: 255
    t.string   "pin",              limit: 255
    t.string   "background_color", limit: 255
    t.string   "text_color",       limit: 255
    t.boolean  "is_active",                    default: true
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["employee_number"], name: "index_users_on_employee_number", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "assigned_permissions", "permissions"
  add_foreign_key "assigned_permissions", "users"
  add_foreign_key "employee_notes", "users", column: "employee"
  add_foreign_key "employee_notes", "users", column: "entered_by"
  add_foreign_key "shift_notes", "users", column: "entered_by"
end
