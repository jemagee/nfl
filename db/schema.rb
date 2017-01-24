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

ActiveRecord::Schema.define(version: 20170124032523) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "divisions", force: :cascade do |t|
    t.string   "name"
    t.string   "conference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.date     "gamedate"
    t.integer  "nflcomid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "team_id"
    t.string   "homeaway"
    t.string   "winlosstie"
    t.integer  "q1"
    t.integer  "q2"
    t.integer  "q3"
    t.integer  "q4"
    t.integer  "q5"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_participants_on_game_id", using: :btree
    t.index ["team_id"], name: "index_participants_on_team_id", using: :btree
  end

  create_table "passing_statistics", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "participant_id"
    t.integer  "att"
    t.integer  "cmp"
    t.integer  "yds"
    t.integer  "tds"
    t.integer  "ints"
    t.integer  "twopta"
    t.integer  "twoptm"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["participant_id"], name: "index_passing_statistics_on_participant_id", using: :btree
    t.index ["player_id"], name: "index_passing_statistics_on_player_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.string   "oldid"
    t.integer  "nflcomid"
    t.integer  "height"
    t.date     "birth_date"
    t.string   "college"
    t.integer  "draft_year",   default: 0
    t.integer  "draft_round",  default: 0
    t.integer  "round_pick",   default: 0
    t.integer  "overall_pick", default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "draft_team"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "abbr"
    t.string   "city"
    t.string   "nickname"
    t.integer  "division_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["division_id"], name: "index_teams_on_division_id", using: :btree
  end

  add_foreign_key "participants", "games"
  add_foreign_key "participants", "teams"
  add_foreign_key "passing_statistics", "participants"
  add_foreign_key "passing_statistics", "players"
  add_foreign_key "players", "teams", column: "draft_team"
  add_foreign_key "teams", "divisions"
end
