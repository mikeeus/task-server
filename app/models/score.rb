class Score < ApplicationRecord
  belongs_to :user

  default_scope { order('created_at DESC') }

  scope(:today, -> { where('scores.created_at > now()::date') })
end
