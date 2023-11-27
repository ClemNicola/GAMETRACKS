class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :category, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :license_id, :string
    add_column :users, :phone, :string
    add_column :users, :sex, :string
    add_column :users, :description, :text
    add_column :users, :position, :string
    add_column :users, :height, :float
  end
end
