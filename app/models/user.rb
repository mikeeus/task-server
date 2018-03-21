class User < ApplicationRecord
  scope(:leaderboard, -> { where('daily_score_count > 0') })
end
