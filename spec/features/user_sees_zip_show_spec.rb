require 'rails_helper'

describe 'user visits zip show page' do
  it 'shows zip info' do
    state = State.create(abbreviation: 'CO')
    zip = Zip.create(id: 80202, n1: 5000, mars1: 2000, mars2: 2500, mars4: 1000, prep: 750, numdep: 3000, elderly: 750, a00100: 4000000, state: state)

    visit zip_path(zip)

    expect(page).to have_content(zip.id)
    expect(page).to have_content("Located in: #{state.abbreviation}")
    expect(page).to have_content("Number of Returns: #{zip.n1}")
    expect(page).to have_content("Percent Single: #{((zip.mars1.to_f / zip.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Percent Joint File: #{((zip.mars2.to_f / zip.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Percent HOH: #{((zip.mars4.to_f / zip.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Percent Paid Prep: #{((zip.prep.to_f / zip.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Average Number of Dependents: #{(zip.numdep.to_f / zip.n1.to_f)}")
    expect(page).to have_content("Percent Elderly: #{((zip.elderly.to_f / zip.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Mean Adjusted Gross Income*: #{((zip.a00100.to_f / zip.n1.to_f) * 100).to_i}")
  end
end