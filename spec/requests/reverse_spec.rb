require 'rails_helper'

RSpec.describe 'reverse', type: :request do
  describe 'reverse#reverse' do
    it 'reverses a word' do
      original_msg = 'reverse this!'
      reversed = '!siht esrever'

      post reverse_path, params: { message: original_msg }

      res = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(res).to eq 'original' => { 'data' => original_msg },
                        'message' => reversed
    end
  end
end
