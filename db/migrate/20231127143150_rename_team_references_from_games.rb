class RenameTeamReferencesFromGames < ActiveRecord::Migration[7.1]
  def change
    change_table :games do |t|
      t.remove :team_id
    end
  end
end
