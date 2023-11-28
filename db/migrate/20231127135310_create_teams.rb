class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :club_name
      t.string :age_level
      t.string :category
      t.string :city
      t.references :coach, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
