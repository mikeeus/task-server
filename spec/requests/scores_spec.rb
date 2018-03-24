require 'rails_helper'

RSpec.describe 'scores', type: :request do
  describe 'scores' do
    let(:dinesh) { create(:user, name: 'Dinesh') }
    let(:gilfoyle) { create(:user, name: 'Gilfoyle') }
    let(:richard) { create(:user, name: 'Richard') }

    describe 'scores#create' do
      it 'creates a score' do
        points_for(dinesh, 2)
        reload_users
        expect(response).to have_http_status(201)

        res = JSON.parse(response.body)
        expect(res['name']).to eq 'Dinesh'
        expect(res['daily_score']).to eq 2
        expect(res['latest_score']).to eq 2
      end
    end

    describe 'scores#index' do
      it 'returns users with at least one score today' do
        points_for(dinesh, 2)
        points_for(dinesh, -2)
        points_for(richard, 1)

        reload_users

        expect(dinesh.daily_score).to eq 0
        expect(richard.daily_score).to eq 1
        expect(gilfoyle.daily_score).to eq 0

        get scores_path
        expect(response).to have_http_status(200)

        res = JSON.parse(response.body)

        expect(res.length).to eq 2
        expect(res.first['name']).to eq 'Richard'
        expect(res[1]['name']).to eq 'Dinesh'
      end
    end

    describe 'scores#scoreless' do
      it 'returns users with no scores today' do
        points_for(dinesh, 1)
        reload_users

        get scoreless_path
        expect(response).to have_http_status(200)

        res = JSON.parse(response.body)
        expect(res.length).to eq 2
        expect(res.map{ |x| x['name'] }).to_not include 'Dinesh'
      end
    end

    describe 'scores#regenerate_scores' do
      it 'removes existing scores and creates new ones' do
        reload_users

        post regenerate_scores_path, params: { score_count: 10 }
        expect(Score.count).to eq 10
        score_counts = [dinesh, richard, gilfoyle].map(&:scores).map(&:count)
        expect(score_counts).to include 0
      end
    end
  end

  def reload_users
    dinesh.reload
    richard.reload
    gilfoyle.reload
  end

  def points_for(user, value)
    post scores_path, params: { score: { user_id: user.id, value: value } }
  end
end
