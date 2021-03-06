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

ActiveRecord::Schema.define(version: 2018_12_03_044225) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "packages", force: :cascade do |t|
    t.string "shipper"
    t.string "recipient"
    t.integer "total_weight"
    t.decimal "total_charge"
    t.integer "overweight"
    t.string "numero_rastreo"
    t.integer "peso_kilogramos"
    t.integer "peso_volumetrico"
    t.integer "peso_total"
    t.integer "fedex_peso_kilogramos"
    t.integer "fedex_peso_volumetrico"
    t.integer "fedex_peso_total"
    t.integer "sobrepeso"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "name"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
