class Participation < ApplicationRecord
  belongs_to :team
  belongs_to :game
  belongs_to :user
  has_one :player_stat

  def player_name
    user.name
  end
end
