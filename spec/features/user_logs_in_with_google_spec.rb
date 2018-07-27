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
  it 'logs in with google' do
    stub_omniauth

    visit root_path
    expect(page).to_not have_content('Logout')

    click_on 'Sign in with Google'

    expect(page).to have_content('Welcome, Steve')
    expect(page).to have_link('Logout')
  end
end

describe 'user visits login page' do
end

describe 'user logs out' do
end
