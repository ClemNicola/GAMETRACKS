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

ActiveRecord::Schema[7.1].define(version: 2023_11_28_170735) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_stats", force: :cascade do |t|
    t.integer "point"
    t.integer "fg_made"
    t.integer "fg_attempt"
    t.integer "threep_made"
    t.integer "threep_attempt"
    t.integer "ft_made"
    t.integer "ft_attempt"
    t.integer "off_rebound"
    t.integer "def_rebound"
    t.integer "assist"
    t.integer "turnover"
    t.integer "steal"
    t.integer "block"
    t.integer "fault"
    t.integer "evaluation"
    t.bigint "game_id", null: false
    t.bigint "teams_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_stats_on_game_id"
    t.index ["teams_id"], name: "index_game_stats_on_teams_id"
  end

  create_table "games", force: :cascade do |t|
    t.date "date"
    t.time "time"
    t.string "arena"
    t.text "arena_address"
    t.integer "score_home_team"
    t.integer "score_away_team"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "winner_id"
    t.index ["winner_id"], name: "index_games_on_winner_id"
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "game_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "home?", default: false
    t.index ["game_id"], name: "index_participations_on_game_id"
    t.index ["team_id"], name: "index_participations_on_team_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "player_stats", force: :cascade do |t|
    t.integer "minute"
    t.integer "point"
    t.integer "fg_made"
    t.integer "fg_attempt"
    t.integer "threep_made"
    t.integer "threep_attempt"
    t.integer "ft_made"
    t.integer "ft_attempt"
    t.integer "off_rebound"
    t.integer "def_rebound"
    t.integer "assist"
    t.integer "turnover"
    t.integer "steal"
    t.integer "block"
    t.integer "fault"
    t.integer "evaluation"
    t.bigint "participations_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participations_id"], name: "index_player_stats_on_participations_id"
  end

  create_table "team_players", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_players_on_team_id"
    t.index ["user_id"], name: "index_team_players_on_user_id"
  end

  create_table "team_stats", force: :cascade do |t|
    t.integer "total_wins"
    t.integer "total_losses"
    t.integer "total_point"
    t.integer "total_fg_made"
    t.integer "total_fg_attempt"
    t.integer "total_threep_made"
    t.integer "total_threep_attempt"
    t.integer "total_ft_made"
    t.integer "total_ft_attempt"
    t.integer "total_off_rebound"
    t.integer "total_def_rebound"
    t.integer "total_assist"
    t.integer "total_turnover"
    t.integer "total_steal"
    t.integer "total_block"
    t.integer "total_fault"
    t.integer "total_evaluation"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_stats_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "club_name"
    t.string "age_level"
    t.string "category"
    t.string "city"
    t.bigint "coach_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coach_id"], name: "index_teams_on_coach_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.string "name"
    t.date "date_of_birth"
    t.string "license_id"
    t.string "phone"
    t.string "sex"
    t.text "description"
    t.string "position"
    t.integer "height"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "game_stats", "games"
  add_foreign_key "game_stats", "teams", column: "teams_id"
  add_foreign_key "games", "teams", column: "winner_id"
  add_foreign_key "participations", "games"
  add_foreign_key "participations", "teams"
  add_foreign_key "participations", "users"
  add_foreign_key "player_stats", "participations", column: "participations_id"
  add_foreign_key "team_players", "teams"
  add_foreign_key "team_players", "users"
  add_foreign_key "team_stats", "teams"
  add_foreign_key "teams", "users", column: "coach_id"
end
