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

ActiveRecord::Schema.define(version: 2020_02_22_085823) do

  create_table "bases", force: :cascade do |t|
    t.integer "factory_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["factory_id"], name: "index_bases_on_factory_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.string "yomigana"
    t.integer "work_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["work_id"], name: "index_characters_on_work_id"
  end

  create_table "factories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kigurumi_images", force: :cascade do |t|
    t.integer "kigurumi_id"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kigurumi_id"], name: "index_kigurumi_images_on_kigurumi_id"
  end

  create_table "kigurumis", force: :cascade do |t|
    t.integer "character_id"
    t.integer "factory_id"
    t.integer "customizer_id"
    t.integer "base_id"
    t.integer "owner_id"
    t.integer "previous_owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_id"], name: "index_kigurumis_on_base_id"
    t.index ["character_id"], name: "index_kigurumis_on_character_id"
    t.index ["customizer_id"], name: "index_kigurumis_on_customizer_id"
    t.index ["factory_id"], name: "index_kigurumis_on_factory_id"
    t.index ["owner_id"], name: "index_kigurumis_on_owner_id"
    t.index ["previous_owner_id"], name: "index_kigurumis_on_previous_owner_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "other_name"
    t.string "yomigana"
    t.integer "birth_year"
    t.boolean "birth_is_reliable"
    t.date "birthday"
    t.integer "home_prefecture_id"
    t.integer "prefecture_id"
    t.string "twitter"
    t.boolean "lives_with_parents"
    t.boolean "is_student"
    t.text "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["home_prefecture_id"], name: "index_people_on_home_prefecture_id"
    t.index ["prefecture_id"], name: "index_people_on_prefecture_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "works", force: :cascade do |t|
    t.string "name"
    t.string "yomigana"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
