class RemoveQuarterFromTeamStats < ActiveRecord::Migration[7.1]
  def change
    remove_column :team_stats, :Q1, :integer
    remove_column :team_stats, :Q2, :integer
    remove_column :team_stats, :Q3, :integer
    remove_column :team_stats, :Q4, :integer
    remove_column :team_stats, :OT, :integer
  end
end
