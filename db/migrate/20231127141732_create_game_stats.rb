class CreateGameStats < ActiveRecord::Migration[7.1]
  def change
    create_table :game_stats do |t|
      t.integer :point
      t.integer :fg_made
      t.integer :fg_attempt
      t.integer :threep_made
      t.integer :threep_attempt
      t.integer :ft_made
      t.integer :ft_attempt
      t.integer :off_rebound
      t.string :def
      t.integer :rebound
      t.integer :assist
      t.integer :turnover
      t.integer :steal
      t.integer :block
      t.integer :fault
      t.integer :evaluation
      t.references :game, null: false, foreign_key: true
      t.references :teams, null: false, foreign_key: true

      t.timestamps
    end
  end
end
