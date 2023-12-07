class AddCoachCategoryToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :coach_category, :string
  end
end
