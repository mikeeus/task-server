class Score < ApplicationRecord
  belongs_to :user
  counter_culture :user,
                  delta_column: 'value',
                  column_name: proc { |model|
                    model.created_at.today? ? 'daily_score' : nil
                  }
  counter_culture :user,
                  deta_column: 'value',
                  column_name: 'daily_score_count'
end
