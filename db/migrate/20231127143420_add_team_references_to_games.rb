class AddTeamReferencesToGames < ActiveRecord::Migration[7.1]
  def change
    change_table :games do |t|
      t.references :winner, foreign_key: { to_table: :teams }
    end
  end
end
