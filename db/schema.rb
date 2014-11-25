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

ActiveRecord::Schema.define(version: 20141124095240) do

  create_table "chapters", force: true do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "dict_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chapters", ["dict_id"], name: "index_chapters_on_dict_id", using: :btree

  create_table "dicts", force: true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recite_tasks", force: true do |t|
    t.integer  "task_type"
    t.text     "word_ids"
    t.integer  "user_id"
    t.datetime "start_time"
    t.datetime "next_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "tmp_record"
  end

  add_index "recite_tasks", ["user_id"], name: "index_recite_tasks_on_user_id", using: :btree

  create_table "recite_words", force: true do |t|
    t.integer  "recite_task_id"
    t.integer  "word_id"
    t.integer  "user_id"
    t.integer  "score"
    t.integer  "dict_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recite_words", ["dict_id"], name: "index_recite_words_on_dict_id", using: :btree
  add_index "recite_words", ["recite_task_id"], name: "index_recite_words_on_recite_task_id", using: :btree
  add_index "recite_words", ["user_id"], name: "index_recite_words_on_user_id", using: :btree
  add_index "recite_words", ["word_id"], name: "index_recite_words_on_word_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "word_chapters", force: true do |t|
    t.integer  "word_id"
    t.integer  "chapter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "word_chapters", ["chapter_id"], name: "index_word_chapters_on_chapter_id", using: :btree
  add_index "word_chapters", ["word_id"], name: "index_word_chapters_on_word_id", using: :btree

  create_table "word_dicts", force: true do |t|
    t.integer  "word_id"
    t.integer  "dict_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "word_dicts", ["dict_id"], name: "index_word_dicts_on_dict_id", using: :btree
  add_index "word_dicts", ["word_id"], name: "index_word_dicts_on_word_id", using: :btree

  create_table "words", force: true do |t|
    t.string   "content"
    t.string   "mean"
    t.string   "w_type"
    t.string   "phonetic"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
