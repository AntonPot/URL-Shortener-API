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

ActiveRecord::Schema.define(version: 2020_10_08_075318) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accesses", force: :cascade do |t|
    t.string "address", null: false
    t.bigint "link_id", null: false
    t.bigint "ip_country_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ip_country_id"], name: "index_accesses_on_ip_country_id"
    t.index ["link_id"], name: "index_accesses_on_link_id"
  end

  create_table "ip_countries", force: :cascade do |t|
    t.string "address", null: false
    t.string "country_code"
    t.string "country_name"
    t.string "country_emoji"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "links", force: :cascade do |t|
    t.string "url", null: false
    t.string "slug", null: false
    t.integer "usage_counter"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_links_on_slug"
  end

  add_foreign_key "accesses", "ip_countries"
  add_foreign_key "accesses", "links"
end
