class AddHomeAwayQuarterToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :Q1_home, :integer
    add_column :games, :Q2_home, :integer
    add_column :games, :Q3_home, :integer
    add_column :games, :Q4_home, :integer
    add_column :games, :OT_home, :integer
    add_column :games, :Q1_away, :integer
    add_column :games, :Q2_away, :integer
    add_column :games, :Q3_away, :integer
    add_column :games, :Q4_away, :integer
    add_column :games, :OT_away, :integer
  end
end
