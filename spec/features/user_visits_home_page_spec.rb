require 'rails_helper'

describe 'user visits home page' do
  it 'has a welcome message and links' do
    visit '/'

    expect(page).to have_content("Welcome to AnalyZip")
    expect(page).to have_link(href: states_path)
    expect(page).to have_link(href: zips_path)
  end

  it 'can navigate to nav links' do
    allow_any_instance_of(Google).to receive(:center).and_return({"lat" => 0, "lng" => 0})
    allow_any_instance_of(Google).to receive(:bounds).and_return({"northeast" => {"lat" => 0, "lng" => 0}, "southwest" => {"lat" => 0, "lng" => 0}})

    visit '/'

    expect(page.body).to include("<title>AnalyZip</title>")
    expect(page.body).to include('<meta name="description" content="Analyze socio-economic, health, tax and other data with maps for zip codes, states and other geographic entities.">')

    within('.nav-wrapper') do
      click_on 'States'
      expect(current_path).to eq(states_path)
      expect(page.body).to include("<title>All States - AnalyZip</title>")

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
