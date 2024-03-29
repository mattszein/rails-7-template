# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_15_204031) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "passwordless_sessions", force: :cascade do |t|
    t.string "authenticatable_type"
    t.bigint "authenticatable_id"
    t.datetime "timeout_at", precision: nil, null: false
    t.datetime "expires_at", precision: nil, null: false
    t.datetime "claimed_at", precision: nil
    t.string "token_digest", null: false
    t.string "identifier", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["authenticatable_type", "authenticatable_id"], name: "authenticatable"
    t.index ["identifier"], name: "index_passwordless_sessions_on_identifier", unique: true
  end

  create_table "permissions", force: :cascade do |t|
    t.string "resource"
    t.integer "role_ids", default: [1], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource"], name: "index_permissions_on_resource", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "priority"
    t.integer "status"
    t.bigint "created_id"
    t.bigint "assigned_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_id"], name: "index_tickets_on_assigned_id"
    t.index ["created_id"], name: "index_tickets_on_created_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "tickets", "users", column: "assigned_id"
  add_foreign_key "tickets", "users", column: "created_id"
  add_foreign_key "users", "roles"
end
