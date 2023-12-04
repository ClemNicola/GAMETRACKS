class Participation < ApplicationRecord
  belongs_to :team
  belongs_to :game
  belongs_to :user
  has_one :player_stat
end
