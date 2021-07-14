require 'rails_helper'
require_relative '../support/devise'

RSpec.describe MovieController, type: :controller do
  describe 'Test movie controller success case' do
    before do
      @user = FactoryBot.create(:user)
      @movie = FactoryBot.create(:movie, youtube_id: 'abcxyz12345')
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
    #     youtube_id: 'xRKhIq6HNBY',
    #     description: 'test stringgggg'
    #   }})
    #   expect(response.status).to eq(500)
    # end

    it  'create new sharing from FE successful' do
      sign_in @user
      post :share, xhr: true, params: { movie: {
        title: 'test-movieee',
        youtube_id: 'xRKhIq6HNBY',
        description: 'test stringgggg'
      }}

      expect(response).to have_http_status(:successful)

      req_body = JSON.parse(response.body)
      expect(req_body['message']).to eq('success')

      movie = JSON.parse(req_body['movie'])
      expect(movie['author_id']).to eq(@user.id.to_s)
    end

    it 'create a sharing movie' do
      sign_in @user
      post :share, params: {
        movie: { youtube_id: 'xRKhIq6HNBY', description: 'Testttt', title: 'TestForce' }
      }

      expect(response).to have_http_status(:successful)
    end

    it 'upvote a sharing movie' do
      sign_in @user
      post :vote, params: {
        movie: { id: @movie.id.to_s, type: 'up' }
      }

      expect(response).to have_http_status(:successful)

      res_body = JSON.parse(response.body)

      expect(res_body['movie']['up_count']).to eq(1)
      expect(res_body['movie']['current_vote']).to eq('up')
    end

    it 'downvote a sharing movie' do
      sign_in @user
      post :vote, params: {
        movie: { id: @movie.id.to_s, type: 'down' }
      }

      expect(response).to have_http_status(:successful)

      res_body = JSON.parse(response.body)

      expect(res_body['movie']['down_count']).to eq(1)
      expect(res_body['movie']['current_vote']).to eq('down')
    end
  end

  describe 'Test movie controller failure case' do
    before do
      @user = FactoryBot.create(:user)
      @movie = FactoryBot.create(:movie)
    end

    it  'create new sharing from FE failure with wrong params' do
      sign_in @user
      post :share, xhr: true, params: { movie: {
        title: '',
        youtube_id: '',
        description: 'test stringgggg'
      }}

      expect(response.status).to eq(406)

      req_body = JSON.parse(response.body)
      expect(req_body['message']).to include('Youtube can\'t be blank')
      expect(req_body['message']).to include('Youtube is too short (minimum is 8 characters)')
    end

    it  'create new sharing from FE failure with duplicate youtube id' do
      sign_in @user
      post :share, xhr: true, params: { movie: {
        title: 'test',
        youtube_id: 'xRKhIq6HNBY',
        description: 'test stringgggg'
      }}

      expect(response.status).to eq(406)

      req_body = JSON.parse(response.body)
      expect(req_body['message']).to include('Youtube is already taken')
    end

    it 'upvote a sharing movie with unauthorized' do
      post :vote, params: {
        movie: { id: @movie.id.to_s, type: 'up' }
      }

      expect(response.status).to eq(302)
    end

    it 'upvote a sharing movie with movie id not found' do
      sign_in @user
      post :vote, params: {
        movie: { id: Random.hex(12), type: 'up' }
      }

      expect(response.status).to eq(404)

      res_body = JSON.parse(response.body)
      expect(res_body['message']).to include('Document(s) not found for class Movie')
    end

    it 'downvote a sharing movie with movie id not found' do
      sign_in @user
      post :vote, params: {
        movie: { id: Random.hex(12), type: 'down' }
      }

      expect(response.status).to eq(404)

      res_body = JSON.parse(response.body)
      expect(res_body['message']).to include('Document(s) not found for class Movie')
    end

    it 'downvote a sharing movie with type not found' do
      sign_in @user
      post :vote, params: {
        movie: { id: @movie.id.to_s, type: 'huan' }
      }

      expect(response.status).to eq(406)
    end
  end
end
