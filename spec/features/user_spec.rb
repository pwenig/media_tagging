require 'rails_helper'

RSpec.feature 'User', type: :feature do
  before do
    visit('/')
    @user = FactoryGirl.create(:user)
  end

  it 'logs in an existing user' do
    fill_in('email-login', with: @user.email)
    fill_in('password-login', with: @user.password)
    click_on('Log In')
    expect(page).to have_text('Signed in successfully.')
  end

  it 'logs out a user' do
    fill_in('email-login', with: @user.email)
    fill_in('password-login', with: @user.password)
    click_on('Log In')
    click_on('Log Out')
    expect(page).to_not have_text('Logged in User')
    expect(page).to have_text('Signed out successfully.')
  end
end
