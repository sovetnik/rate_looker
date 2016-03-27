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
    it 'returns http redirect' do
      post :update, exchange: { custom_rate: 42, expires_at: Time.current + 1.hour }
      expect(response).to have_http_status(:found)
    end
  end
end
