class RenameHomeInParticipations < ActiveRecord::Migration[7.1]
  def change
    rename_column :participations, :home, :home?
  end
end
