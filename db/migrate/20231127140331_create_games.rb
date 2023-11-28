class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.date :date
      t.time :time
      t.string :arena
      t.text :arena_address
      t.integer :score_home_team
      t.integer :score_away_team
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
