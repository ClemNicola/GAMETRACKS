class RenameFirstNameFromUser < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :first_name, :name
  end
end
