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

ActiveRecord::Schema.define(version: 2024_06_16_161151) do

  create_table "answers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "text", null: false
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.boolean "is_selected_correct_answer", default: false, null: false
    t.boolean "points_awarded", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "pending", default: false, null: false
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "post_id"
    t.index ["post_id"], name: "index_post_images_on_post_id"
  end

  create_table "posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.json "images"
    t.bigint "user_id"
    t.bigint "category_id"
    t.bigint "view_count", default: 0
    t.boolean "is_resolved"
    t.datetime "confirmed_at"
    t.bigint "resolved_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "privacy_policies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "Chapter1"
    t.text "Chapter2"
    t.text "Chapter3"
    t.text "Chapter4"
    t.text "Chapter5"
    t.text "Chapter6"
    t.text "Chapter7"
    t.text "Chapter8"
    t.text "Chapter9"
    t.text "Chapter10"
    t.text "Chapter1_body"
    t.text "Chapter2_body"
    t.text "Chapter3_body"
    t.text "Chapter4_body"
    t.text "Chapter5_body"
    t.text "Chapter6_body"
    t.text "Chapter7_body"
    t.text "Chapter8_body"
    t.text "Chapter9_body"
    t.text "Chapter10_body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "term_of_services", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.integer "sex", null: false
    t.date "birthday", null: false
    t.string "avatar"
    t.text "self_introduction"
    t.bigint "total_points", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", null: false
  end

end
