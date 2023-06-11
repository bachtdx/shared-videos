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

ActiveRecord::Schema[7.0].define(version: 2023_06_11_100929) do
  create_table "likes", force: :cascade do |t|
    t.integer "shared_video_id", null: false
    t.integer "user_id", null: false
    t.boolean "like"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shared_video_id"], name: "index_likes_on_shared_video_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "shared_videos", force: :cascade do |t|
    t.integer "user_id"
    t.string "video_id"
    t.string "video_title"
    t.text "video_description"
    t.string "video_embed"
    t.integer "video_like"
    t.integer "video_dislike"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_logined"
  end

  add_foreign_key "likes", "shared_videos"
  add_foreign_key "likes", "users"
end
