class RemoveQuarterFromGames < ActiveRecord::Migration[7.1]
  def change
    remove_column :games, :Q1, :integer
    remove_column :games, :Q2, :integer
    remove_column :games, :Q3, :integer
    remove_column :games, :Q4, :integer
    remove_column :games, :OT, :integer
  end
end
