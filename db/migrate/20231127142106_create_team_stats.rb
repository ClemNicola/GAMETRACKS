class CreateTeamStats < ActiveRecord::Migration[7.1]
  def change
    create_table :team_stats do |t|
      t.integer :total_wins
      t.integer :total_losses
      t.integer :total_point
      t.integer :total_fg_made
      t.integer :total_fg_attempt
      t.integer :total_threep_made
      t.integer :total_threep_attempt
      t.integer :total_ft_made
      t.integer :total_ft_attempt
      t.integer :total_off_rebound
      t.integer :total_def_rebound
      t.integer :total_assist
      t.integer :total_turnover
      t.integer :total_steal
      t.integer :total_block
      t.integer :total_fault
      t.integer :total_evaluation
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
