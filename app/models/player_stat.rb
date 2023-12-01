class PlayerStat < ApplicationRecord
  belongs_to :participation
  delegate :user, to: :participation, allow_nil: true, prefix: false

  validates :minute,
            :point,
            :fg_made,
            :fg_attempt,
            :threep_made,
            :threep_attempt,
            :ft_made,
            :ft_attempt,
            :off_rebound,
            :def_rebound,
            :assist,
            :turnover,
            :steal,
            :block,
            :fault,
            :evaluation, numericality: { only_integer: true }

  def player
    last_name = user.name.split(', ').first
    first_name = "#{user.name.split(', ').last[0]}."
    [last_name, first_name].join(' ')
  end
end
