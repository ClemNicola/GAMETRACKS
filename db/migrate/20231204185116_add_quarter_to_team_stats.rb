class AddQuarterToTeamStats < ActiveRecord::Migration[7.1]
  def change
    add_column :team_stats, :Q1, :integer
    add_column :team_stats, :Q2, :integer
    add_column :team_stats, :Q3, :integer
    add_column :team_stats, :Q4, :integer
    add_column :team_stats, :OT, :integer
  end
end
