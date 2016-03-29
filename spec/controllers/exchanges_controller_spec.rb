require 'rails_helper'

RSpec.describe ExchangesController, type: :controller do
  describe 'GET root' do
    it 'returns http success' do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /admin' do
    it 'returns http success' do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST update' do
    it 'render show with http success' do
      post :update, params: {
        exchange: { custom_rate: 42, expires_at: Time.current + 1.hour }
      }
      expect(response).to have_http_status(:ok)
    end
    it 'render edit with http success' do
      post :update, params: {
        exchange: { custom_rate: 'forty two', expires_at: Time.current + 1.hour }
      }
      expect(response).to have_http_status(:ok)
    end
  end
end
