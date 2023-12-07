class AddColumnTitulaireToParticipation < ActiveRecord::Migration[7.1]
  def change
    add_column :participations, :titulaire?, :boolean, default: false
  end
end
