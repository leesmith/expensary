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

ActiveRecord::Schema[8.1].define(version: 2026_05_02_144018) do
  create_table "accounts", force: :cascade do |t|
    t.integer "account_type", default: 0, null: false
    t.decimal "balance", precision: 12, scale: 2
    t.datetime "created_at", null: false
    t.string "description"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["account_type"], name: "index_accounts_on_account_type"
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "group_title", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["group_title", "title"], name: "index_categories_on_group_title_and_title", unique: true
  end

  create_table "category_rules", force: :cascade do |t|
    t.integer "account_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.string "description"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_category_rules_on_account_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "account_id", null: false
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.date "tran_date", null: false
    t.integer "tran_type", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["category_id"], name: "index_transactions_on_category_id"
    t.index ["tran_date"], name: "index_transactions_on_tran_date"
    t.index ["tran_type"], name: "index_transactions_on_tran_type"
  end

  add_foreign_key "category_rules", "accounts"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "transactions", "categories"
end
