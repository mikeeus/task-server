require 'rails_helper'

RSpec.describe 'scores', type: :request do
  describe 'scores' do
    let(:dinesh) { create(:user, name: 'Dinesh') }
    let(:gilfoyle) { create(:user, name: 'Gilfoyle') }

    describe 'scores#create' do
      it 'creates a score' do
        post_for_dinesh(2)

        expect(response).to have_http_status(201)

        res = JSON.parse(response.body)
        expect(res['name']).to eq 'Dinesh'
        expect(res['daily_score']).to eq 2
        expect(res['daily_score_count']).to eq 1
      end
    end

    describe 'scores#index' do
      it 'returns users with at least one daily_score_count' do
        post_for_dinesh(2)
        dinesh.reload
        expect(dinesh.daily_score).to eq 2

        post_for_dinesh(-2)
        dinesh.reload
        expect(dinesh.daily_score).to eq 0
        expect(dinesh.daily_score_count).to eq 2

        gilfoyle.reload
        expect(gilfoyle.daily_score).to eq 0
        expect(gilfoyle.daily_score_count).to eq 0

        get scores_path
        expect(response).to have_http_status(200)

        res = JSON.parse(response.body)

        expect(res.length).to eq 1
        expect(res.first['name']).to eq 'Dinesh'
      end
    end
  end

  def post_for_dinesh(value)
    post scores_path, params: { score: { user_id: dinesh.id, value: value } }
  end
end
