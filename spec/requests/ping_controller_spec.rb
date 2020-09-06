# frozen_string_literal: true

RSpec.describe PingController, type: :request do
  describe 'index' do
    it 'returns HTTP 200' do
      get '/'
      expect(response).to have_http_status(:ok)
    end
    it 'returns {status: :ok , message: comect_service_api is running} as json' do
      get '/'
      expect(JSON.parse(response.body)).to eq('message' => 'comect_service_api is running', 'status' => 'ok')
    end
  end
end
