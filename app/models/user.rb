class User < ApplicationRecord
  has_many :scores, -> { today }

  scope(:leaderboard, lambda {
    joins(:scores).order('sum(scores.value) DESC').group('users.id')
  })

  scope(:scoreless, lambda {
    includes(:scores).where(scores: { user_id: nil })
  })

  def daily_score
    scores.map(&:value).sum
  end

  def latest_score
    scores.first && scores.first.value
  end
end
