class AddColumnTitulaireToParticipation < ActiveRecord::Migration[7.1]
  def change
    add_column :participations, :titulaire?, :boolean
  end
end
