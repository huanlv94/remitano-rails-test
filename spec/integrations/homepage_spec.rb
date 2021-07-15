require 'rails_helper'

describe 'Test homepage', type: :feature, js: true do
  before do
    @user = FactoryBot.create(:user)
    @movie = FactoryBot.create(:movie)
  end

  it 'GET / - view homepage without sign in' do
    visit '/'

    expect(page).to have_content('Funny Movies')
    expect(page).to have_content('Home')
    expect(page).to have_content(@movie.title)
  end

  it 'GET / - view homepage with signed in' do
    visit '/users/sign_in'
    within '#new_user' do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: '123456'
    end

    click_button 'Log in'

    expect(page).to have_content(@movie.title)
  end
end
