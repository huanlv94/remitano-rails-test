require 'rails_helper'

describe 'Test sharing movie', type: :feature, js: true do
  before do
    @user = FactoryBot.create(:user)
    @movie = FactoryBot.create(:movie)
  end

  it 'GET / - logged in and view homepage' do
    visit '/users/sign_in'
    within '#new_user' do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: '123456'
    end

    click_button 'Log in'

    expect(page).to have_content(@movie.title)
  end

  it 'GET /movie/new - logged in and go to share page' do
    visit '/users/sign_in'
    within '#new_user' do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: '123456'
    end

    click_button 'Log in'
    click_link 'Share a movie'

    expect(page).to have_content('Share a movie')
    expect(page).to have_selector(:link_or_button, 'Share')
  end

  it 'POST /movie/new - logged in and share youtube video with invalid URL' do
    visit '/users/sign_in'
    within '#new_user' do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: '123456'
    end

    click_button 'Log in'
    click_link 'Share a movie'

    fill_in 'youtube-url', with: 'https://www.google.com/'

    click_button 'Share'
    expect(page).to have_content("It's not a Youtube URL!")
  end

  it 'POST /movie/new - logged in and share youtube video successfully' do
    visit '/users/sign_in'
    within '#new_user' do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: '123456'
    end

    click_button 'Log in'
    visit '/movie/new'

    fill_in 'youtube-url', with: 'https://www.youtube.com/watch?v=W_8n65MQrl0'

    click_button 'Share'
    expect(page).to have_content('successfully!')

    visit '/'
    expect(page).to have_content("Share by: #{@user.email}")
  end

  it 'POST /movie/vote - logged in and vote up' do
    visit '/users/sign_in'
    within '#new_user' do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: '123456'
    end

    click_button 'Log in'

    expect(page).to have_content(@movie.title)

    all('h6.bi-hand-thumbs-up').each { |vote| vote.click }

    expect(page).to have_css('h6.bi-hand-thumbs-up-fill')
  end

  it 'POST /movie/vote - logged in and vote down' do
    visit '/users/sign_in'
    within '#new_user' do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: '123456'
    end

    click_button 'Log in'

    expect(page).to have_content(@movie.title)

    all('h6.bi-hand-thumbs-down').each { |vote| vote.click }

    expect(page).to have_css('h6.bi-hand-thumbs-down-fill')
  end
end
