class AddColumnToParticipation < ActiveRecord::Migration[7.1]
  def change
    add_column :participations, :selected?, :boolean
  end
end
