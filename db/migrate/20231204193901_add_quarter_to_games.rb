class AddQuarterToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :Q1, :integer
    add_column :games, :Q2, :integer
    add_column :games, :Q3, :integer
    add_column :games, :Q4, :integer
    add_column :games, :OT, :integer
  end
end
