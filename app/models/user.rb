class User < ApplicationRecord
  scope(:leaderboard, lambda {
    where('daily_score_count > 0').order('daily_score DESC')
  })

  scope(:scoreless, lambda {
    where('daily_score_count = 0')
  })
end
