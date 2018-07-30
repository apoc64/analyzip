require 'rails_helper'

def stub_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
      provider: 'google',
      info: {
        first_name: 'Steve',
        last_name: 'Schwedt',
        email: 'sschwedt@gmail.com'
      },
      credentials: {
      token: Rails.application.credentials.google[:test_token]
      }
    })
end

describe 'user visits home page' do
  it 'logs in and out with google' do
    stub_omniauth

    visit root_path
    expect(page).to_not have_content('Logout')
    expect(page).to have_link('Login')

    click_on 'Sign in with Google'

    expect(page).to have_content('Welcome, Steve')
    expect(page).to have_link('Logout')
    expect(page).to_not have_link('Login')

    within('.nav-wrapper') do
      click_on 'Logout'
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_link('Login')
    expect(page).to_not have_link('Logout')

  end
end

describe 'user visits login page' do
  it 'allows user to login with email and password' do
    visit '/'

    within('.nav-wrapper') do
      click_on 'Login'
    end

    expect(current_path).to eq('/Login')
  end
end
