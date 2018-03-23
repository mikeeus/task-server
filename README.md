# Mikias Abera Saleskick Task: Rails API

## Leaderboard

I use a default scope on the score association to only associate scores from today:

```ruby
# app/models/user.rb
has_many :scores, -> { today }

# app/models/score.rb
scope(:today, -> { where('scores.created_at > now()::date') })
```

The users are filtered at the server by using an inner join and ordering by the sum of the scores:

```ruby
# I assumed that the desired order was DESC since it was a leaderboard
scope(:leaderboard, lambda {
  joins(:scores).order('sum(scores.value) DESC').group('users.id')
})
```

I added a seperate button that fetches data using the `scoreless` scope. This checks for users with no associated score for today:

```ruby
scope(:scoreless, lambda {
  includes(:scores).where(scores: { user_id: nil })
})
```

## Reverser

Reversing is done by a rails controller:

```ruby
class ReverseController < ApplicationController

  def reverse
    original = reverse_params[:message] || ''
    reversed = original.reverse

    render json: { original: { data: original }, message: reversed }
  end

  private

  def reverse_params
    params.permit(:message)
  end
end
```

Routes:

```ruby
resources :users, only: %i[index show]

resources :scores, only: %i[index create]
get :scoreless, to: 'scores#scoreless'

post :reverse, to: 'reverse#reverse', as: 'reverse'
```

## Dependencies

Ruby version: 2.3.1
Rails version: 5.1.4
Postgresql

## Tests

Run the test suite with `rspec`

## Deployment instructions

Deploy with heroku:

```bash
heroku create myapp
git push heroku master
heroku run rails db:migrate db:seed
```
