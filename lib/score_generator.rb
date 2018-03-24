class ScoreGenerator
  def initialize(score_count = 50)
    @score_count = score_count
    @pool = generate_user_pool
  end

  def generate
    @score_count.times do
      Score.create(user: random_user_from_pool, value: generate_random_value)
    end
  end

  private

  def random_user_from_pool
    User.find(@pool.sample)
  end

  def generate_random_value
    modifier = [-1, 1].sample
    value = (rand(1000) + 1) * modifier
    value /= 10 if modifier < 0
    value
  end

  def generate_user_pool
    (1..20).to_a.sample(15)
  end
end
