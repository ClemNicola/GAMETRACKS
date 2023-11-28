class EditHeightInUser < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :height, :integer
  end
end
