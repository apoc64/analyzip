require 'rails_helper'

describe 'user visits home page' do
  it 'has a welcome message and links' do
    visit '/'

    expect(page).to have_content("Welcome to Zip Code Analyzer")
    expect(page).to have_link(href: states_path)
    expect(page).to have_link(href: zips_path)
  end
end
