class RenameColumnParticipationsInPlayerStats < ActiveRecord::Migration[7.1]
  def change
    rename_column :player_stats, :participations_id, :participation_id
  end
end
