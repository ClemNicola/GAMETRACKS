class AddHomeTeamToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :home_team, :boolean
    add_column :games, :away_team, :boolean
  end
end
