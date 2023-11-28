class CreatePlayerStats < ActiveRecord::Migration[7.1]
  def change
    create_table :player_stats do |t|
      t.integer :minute
      t.integer :point
      t.integer :fg_made
      t.integer :fg_attempt
      t.integer :threep_made
      t.integer :threep_attempt
      t.integer :ft_made
      t.integer :ft_attempt
      t.integer :off_rebound
      t.integer :def_rebound
      t.integer :assist
      t.integer :turnover
      t.integer :steal
      t.integer :block
      t.integer :fault
      t.integer :evaluation
      t.references :participations, null: false, foreign_key: true

      t.timestamps
    end
  end
end
