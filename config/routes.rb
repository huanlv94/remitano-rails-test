Rails.application.routes.draw do
  get 'movie/index'
  get 'movie/new'
  devise_for :users
  get 'home/index'

  root to: 'home#index'
end
