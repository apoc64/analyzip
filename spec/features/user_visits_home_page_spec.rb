require 'rails_helper'

describe 'user visits home page' do
  it 'has a welcome message and links' do
    visit '/'

    expect(page).to have_content("Welcome to AnalyZip")
    expect(page).to have_link(href: states_path)
    expect(page).to have_link(href: zips_path)
  end

  it 'can navigate to nav links' do
    visit '/'

    within('.nav-wrapper') do
      click_on 'States'
      expect(current_path).to eq(states_path)

      click_on 'Zip Codes'
      expect(current_path).to eq(zips_path)

      click_on 'Counties'
      expect(current_path).to eq(counties_path)

      click_on 'AnalyZip'
      expect(current_path).to eq(root_path)
    end

    within('.sidenav') do
      click_on 'States'
      expect(current_path).to eq(states_path)

      click_on 'Counties'
      expect(current_path).to eq(counties_path)

      click_on 'Zip Codes'
      expect(current_path).to eq(zips_path)
    end
  end
end
