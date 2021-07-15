require 'rails_helper'

describe 'creat new a user', type: :feature, js: true do
  before do
    @user = FactoryBot.create(:user, email: 'dup@huan.com')
  end

  it 'successfully create user' do
    visit 'users/sign_up'

    within '#new_user' do
      fill_in 'Email', with: 'huan@test.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
    end
    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(page).to have_content 'Welcome, huan@test.com'
  end

  it 'failed create user with error email' do
    visit '/users/sign_up'

    within '#new_user' do
      fill_in 'Email', with: ''
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
    end
    click_button 'Sign up'

    expect(page).to have_content "Email can't be blank"
  end

  it 'failed create user with duplicate email' do
    visit '/users/sign_up'

    within '#new_user' do
      fill_in 'Email', with: 'dup@huan.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
    end
    click_button 'Sign up'

    expect(page).to have_content 'Email is already taken'
  end
end

describe 'create new a user and login logout', type: :feature, js: true do
  it 'successfully logged in' do
    visit 'users/sign_up'

    within '#new_user' do
      fill_in 'Email', with: 'huan@test.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
    end
    click_button 'Sign up'

    click_link 'Log out'

    visit 'users/sign_in'
    within '#new_user' do
      fill_in 'Email', with: 'huan@test.com'
      fill_in 'Password', with: '123456'
    end

    click_button 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content 'Welcome, huan@test.com'
  end

  it 'login with user not found' do
    visit 'users/sign_in'
    within '#new_user' do
      fill_in 'Email', with: 'huan@test.com'
      fill_in 'Password', with: '123456'
    end

    click_button 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
  end
end