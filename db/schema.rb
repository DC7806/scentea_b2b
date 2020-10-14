# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_14_153051) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "address"
    t.string "brand_name"
    t.string "contact_email", null: false
    t.string "contact_number"
    t.string "company_name", default: "", null: false
    t.integer "region", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.string "tax_id_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["region"], name: "index_accounts_on_region"
    t.index ["status"], name: "index_accounts_on_status"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "slug", null: false
    t.string "title", default: "", null: false
    t.text "banner_data", null: false
    t.text "content", default: "", null: false
    t.text "summary", default: "", null: false
    t.integer "region", default: 0, null: false
    t.boolean "published", default: true, null: false
    t.datetime "published_at", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id", "title"], name: "index_articles_on_category_id_and_title", unique: true, where: "((title)::text <> ''::text)"
    t.index ["category_id"], name: "index_articles_on_category_id"
    t.index ["region"], name: "index_articles_on_region"
    t.index ["slug"], name: "index_articles_on_slug", unique: true
  end

  create_table "carousels", force: :cascade do |t|
    t.text "image_data", null: false
    t.string "title"
    t.string "subtitle"
    t.string "button_text"
    t.string "button_url"
    t.integer "region", null: false
    t.integer "position", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["position"], name: "index_carousels_on_position"
    t.index ["region"], name: "index_carousels_on_region"
  end

  create_table "categories", force: :cascade do |t|
    t.string "type", null: false
    t.string "name", default: "", null: false
    t.integer "region", default: 0, null: false
    t.integer "position", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["position"], name: "index_categories_on_position"
    t.index ["region"], name: "index_categories_on_region"
    t.index ["type", "region", "name"], name: "index_categories_on_type_and_region_and_name", unique: true, where: "((name)::text <> ''::text)"
  end

  create_table "faqs", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "description", default: "", null: false
    t.integer "region", default: 0, null: false
    t.integer "position", default: 0, null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id", "position"], name: "index_faqs_on_category_id_and_position"
    t.index ["category_id", "title"], name: "index_faqs_on_category_id_and_title", unique: true, where: "((title)::text <> ''::text)"
    t.index ["category_id"], name: "index_faqs_on_category_id"
    t.index ["region"], name: "index_faqs_on_region"
  end

  create_table "mobility_string_translations", force: :cascade do |t|
    t.string "locale", null: false
    t.string "key", null: false
    t.string "value"
    t.string "translatable_type"
    t.bigint "translatable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["translatable_id", "translatable_type", "key"], name: "index_mobility_string_translations_on_translatable_attribute"
    t.index ["translatable_id", "translatable_type", "locale", "key"], name: "index_mobility_string_translations_on_keys", unique: true
    t.index ["translatable_type", "key", "value", "locale"], name: "index_mobility_string_translations_on_query_keys"
  end

  create_table "mobility_text_translations", force: :cascade do |t|
    t.string "locale", null: false
    t.string "key", null: false
    t.text "value"
    t.string "translatable_type"
    t.bigint "translatable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["translatable_id", "translatable_type", "key"], name: "index_mobility_text_translations_on_translatable_attribute"
    t.index ["translatable_id", "translatable_type", "locale", "key"], name: "index_mobility_text_translations_on_keys", unique: true
  end

  create_table "page_sections", force: :cascade do |t|
    t.integer "position", default: 0, null: false
    t.integer "region", default: 0, null: false
    t.integer "style", null: false
    t.bigint "page_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_id"], name: "index_page_sections_on_page_id"
    t.index ["position"], name: "index_page_sections_on_position"
    t.index ["region"], name: "index_page_sections_on_region"
  end

  create_table "pages", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "slug", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "site_settings", force: :cascade do |t|
    t.string "customization_form_url", default: "", null: false
    t.string "fb_id"
    t.string "gtm_id"
    t.string "site_name", default: "", null: false
    t.string "service_email", default: "", null: false
    t.text "logo_data"
    t.text "favicon_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "articles", "categories"
  add_foreign_key "faqs", "categories"
  add_foreign_key "page_sections", "pages", on_delete: :cascade
end
