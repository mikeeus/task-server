require 'rails_helper'

RSpec.describe 'scores', type: :request do
  describe 'scores' do
    let(:dinesh) { create(:user, name: 'Dinesh') }
    let(:gilfoyle) { create(:user, name: 'Gilfoyle') }
    let(:richard) { create(:user, name: 'Richard') }

    describe 'scores#create' do
      it 'creates a score and stores the latest change' do
        points_for(dinesh, 2)

        expect(response).to have_http_status(201)

        res = JSON.parse(response.body)
        expect(res['name']).to eq 'Dinesh'
        expect(res['daily_score']).to eq 2
        expect(res['daily_score_count']).to eq 1
        expect(res['latest_change']).to eq 2
      end
    end

    describe 'scores#index' do
      it 'returns users with at least one daily_score_count' do
        points_for(dinesh, 2)
        points_for(dinesh, -2)
        dinesh.reload
        expect(dinesh.daily_score).to eq 0
        expect(dinesh.daily_score_count).to eq 2

        points_for(richard, 1)
        richard.reload
        expect(richard.daily_score).to eq 1
        expect(richard.daily_score_count).to eq 1

        gilfoyle.reload
        expect(gilfoyle.daily_score).to eq 0
        expect(gilfoyle.daily_score_count).to eq 0

        get scores_path
        expect(response).to have_http_status(200)

        res = JSON.parse(response.body)

        expect(res.length).to eq 2
        expect(res.first['name']).to eq 'Richard'
        expect(res[1]['name']).to eq 'Dinesh'
      end
    end

    describe 'scores#scoreless' do
      it 'returns users with 0 daily_score_count' do
        points_for(dinesh, 1)
        dinesh.reload
        expect(dinesh.daily_score_count).to eq 1

        richard.reload
        gilfoyle.reload
        expect(richard.daily_score_count).to eq 0
        expect(gilfoyle.daily_score_count).to eq 0

        get scoreless_path
        expect(response).to have_http_status(200)

        res = JSON.parse(response.body)
        expect(res.length).to eq 2
        expect(res.map{ |x| x['name'] }).to_not include 'Dinesh'
      end
    end
  end

  def points_for(user, value)
    post scores_path, params: { score: { user_id: user.id, value: value } }
  end
end
