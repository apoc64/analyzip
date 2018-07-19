require 'rails_helper'

describe 'user visits state show page' do
  it 'shows one state' do
    state = create(:state)
    zip1 = state.zips.create(id: 80205, n1: 4000)
    zip2 = state.zips.create(id: 80203, n1: 4000)
    zip3 = create(:zip)

    visit state_path(state)

    expect(page).to have_content(state.abbreviation)
    expect(page).to have_link(zip1.id)
    expect(page).to have_link(zip2.id)
    expect(page).to_not have_link(zip3.id)

    expect(page).to have_content("No. of Returns: 15,000")
    expect(page).to have_content("Percent Single: #{((state.mars1.to_f / state.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Percent Joint File: #{((state.mars2.to_f / state.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Percent HOH: #{((state.mars4.to_f / state.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Percent Paid Prep: #{((state.prep.to_f / state.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Avg No. Dependents: 1.53")
    expect(page).to have_content("Percent Elderly: #{((state.elderly.to_f / state.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Avg Income: $200,000")

    # expect(page).to have_css('.map')
  end
end
