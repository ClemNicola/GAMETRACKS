class RenameUsersToUserInParticipations < ActiveRecord::Migration[7.1]
  def change
    rename_column :participations, :users_id, :user_id
    rename_column :participations, :teams_id, :team_id
  end
end
