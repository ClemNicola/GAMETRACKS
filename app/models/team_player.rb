class TeamPlayer < ApplicationRecord
  belongs_to :player, class_name: :User, foreign_key: :user_id
  belongs_to :team
end
