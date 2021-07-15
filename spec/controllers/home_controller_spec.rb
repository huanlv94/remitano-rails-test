require 'rails_helper'
require_relative '../support/devise'

RSpec.describe HomeController, type: :controller do
  describe '#index' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'responds 200:OK' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'responds successfully' do
      get :index
      expect(response).to have_http_status(:successful)
    end

    it 'returns  a 200 response when signed_in' do
      sign_in @user
      get :index
      expect(response).to have_http_status('200')
    end
  end
end
