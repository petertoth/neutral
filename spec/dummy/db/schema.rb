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

ActiveRecord::Schema.define(version: 20140118172808882161) do

  create_table "neutral_votes", force: true do |t|
    t.string   "voteable_type"
    t.integer  "voteable_id"
    t.integer  "voter_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "neutral_votes", ["voteable_type", "voteable_id"], name: "index_neutral_votes_on_voteable_type_and_voteable_id"
  add_index "neutral_votes", ["voter_id"], name: "index_neutral_votes_on_voter_id"

  create_table "neutral_votings", force: true do |t|
    t.string   "votingable_type"
    t.integer  "votingable_id"
    t.integer  "positive",        default: 0
    t.integer  "negative",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
