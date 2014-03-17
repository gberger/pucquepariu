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

ActiveRecord::Schema.define(version: 20140317011124) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_messages", force: true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_ads", force: true do |t|
    t.string   "image"
    t.string   "link"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.integer  "credits"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "study_plan",   default: ""
    t.integer  "teacher_id"
  end

  add_index "courses", ["abbreviation"], name: "index_courses_on_abbreviation", using: :btree
  add_index "courses", ["name"], name: "index_courses_on_name", using: :btree

  create_table "courses_majors", force: true do |t|
    t.integer "course_id"
    t.integer "major_id"
  end

  create_table "exams", force: true do |t|
    t.integer  "year"
    t.integer  "semester"
    t.integer  "number"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exams", ["course_id"], name: "index_exams_on_course_id", using: :btree

  create_table "majors", force: true do |t|
    t.string "name"
  end

  create_table "study_materials", force: true do |t|
    t.integer  "course_id"
    t.integer  "exam_id"
    t.string   "content"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "study_materials", ["course_id"], name: "index_study_materials_on_course_id", using: :btree
  add_index "study_materials", ["exam_id"], name: "index_study_materials_on_exam_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "nickname"
    t.string   "email"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",             default: "basic", null: false
  end

end
