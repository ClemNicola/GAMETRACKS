class CreateTeamPlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :team_players do |t|
      t.references :user, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
