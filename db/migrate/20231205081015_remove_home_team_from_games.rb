class RemoveHomeTeamFromGames < ActiveRecord::Migration[7.1]
  def change
    remove_column :games, :home_team, :boolean
    remove_column :games, :away_team, :boolean
  end
end
