class AddHomeToParticipations < ActiveRecord::Migration[7.1]
  def change
    add_column :participations, :home, :boolean, default: false
  end
end
