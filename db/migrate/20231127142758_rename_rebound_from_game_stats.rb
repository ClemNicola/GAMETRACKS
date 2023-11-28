class RenameReboundFromGameStats < ActiveRecord::Migration[7.1]
  def change
    change_table :game_stats do |t|
      t.rename :rebound, :def_rebound
    end
  end
end
