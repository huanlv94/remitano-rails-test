require 'rails_helper'
require_relative '../support/devise'

RSpec.describe MovieController, type: :controller do
  describe 'Test movie controller success case' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'responds 302 when unauthorized' do
      get :new
      expect(response.status).to eq(302)
    end

    it 'responds 200:OK' do
      sign_in @user
      get :new
      expect(response.status).to eq(200)
    end

    it  'responds successfully when visit new sharing' do
      sign_in @user
      get :new
      expect(response).to render_template(:new)
      expect(response).to have_http_status(:successful)
    end

    it  'response 302 when create share with unauthorized' do
      post :share
      expect(response.status).to eq(302)
    end

    # it  'response 500 when create share with no strong params' do
    #   sign_in @user
    #   post :share
    #   should permit(:movie).for(:share, params: { movie: {
    #     title: 'test-movieee',
    #     url: 'https://www.youtube.com/watch?v=xRKhIq6HNBY',
    #     description: 'test stringgggg'
    #   }})
    #   expect(response.status).to eq(500)
    # end

    it  'create new sharing from FE successful' do
      sign_in @user
      post :share, xhr: true, params: { movie: {
        title: 'test-movieee',
        url: 'https://www.youtube.com/watch?v=xRKhIq6HNBY',
        description: 'test stringgggg',
        author: @user.id.to_s
      }}

      expect(response).to have_http_status(:successful)

      req_body = JSON.parse(response.body)
      expect(req_body['message']).to eq('success')

      movie = JSON.parse(req_body['movie'])
      expect(movie['author_id']).to eq(@user.id.to_s)
    end

    it 'creates a sharing movie' do
      sign_in @user
      post :share, params: {movie: 
        { url: 'https://www.youtube.com/watch?v=xRKhIq6HNBY', description: 'Testttt', title: 'TestForce', author: @user.id.to_s }}
    end
  end
end
