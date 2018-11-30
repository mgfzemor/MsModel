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

ActiveRecord::Schema.define(version: 2018_11_30_171627) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "columns", force: :cascade do |t|
    t.string "system_name"
    t.string "database_name"
    t.boolean "nn"
    t.boolean "uq"
    t.boolean "bin"
    t.boolean "un"
    t.boolean "zf"
    t.boolean "g"
    t.bigint "ms_column_types_id"
    t.bigint "tables_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ms_column_types_id"], name: "index_columns_on_ms_column_types_id"
    t.index ["tables_id"], name: "index_columns_on_tables_id"
  end

  create_table "foreign_keys", force: :cascade do |t|
    t.integer "source_column", null: false
    t.integer "source_table", null: false
    t.integer "target_column", null: false
    t.integer "target_table", null: false
  end

  create_table "ms_column_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "prefix"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "rails_types_id"
    t.index ["rails_types_id"], name: "index_ms_column_types_on_rails_types_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rails_types", force: :cascade do |t|
    t.string "name"
    t.boolean "active_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "table_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "prefix"
  end

  create_table "tables", force: :cascade do |t|
    t.string "system_name"
    t.string "database_name"
    t.boolean "active_id"
    t.boolean "active_created"
    t.boolean "active_updated"
    t.bigint "projects_id"
    t.bigint "table_types_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["projects_id"], name: "index_tables_on_projects_id"
    t.index ["table_types_id"], name: "index_tables_on_table_types_id"
  end

  add_foreign_key "columns", "ms_column_types", column: "ms_column_types_id"
  add_foreign_key "columns", "tables", column: "tables_id"
  add_foreign_key "foreign_keys", "columns", column: "source_column"
  add_foreign_key "foreign_keys", "columns", column: "target_column"
  add_foreign_key "foreign_keys", "tables", column: "source_table"
  add_foreign_key "foreign_keys", "tables", column: "target_table"
  add_foreign_key "ms_column_types", "rails_types", column: "rails_types_id"
end
