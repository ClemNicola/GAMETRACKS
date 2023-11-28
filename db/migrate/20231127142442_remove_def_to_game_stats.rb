class RemoveDefToGameStats < ActiveRecord::Migration[7.1]
  def change
    remove_column :game_stats, :def
  end
end
