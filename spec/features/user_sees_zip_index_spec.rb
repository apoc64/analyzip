require 'rails_helper'

describe 'user visits zip index page' do
  it 'shows high and low income zips' do
    state = State.create(abbreviation: 'CO')
    zip1 = Zip.create(id: 80202, n1: 5000, mars1: 2000, mars2: 2500, mars4: 1000, prep: 750, numdep: 3000, elderly: 750, a00100: 1000000, state: state)
    zip2 = Zip.create(id: 80205, n1: 5000, mars1: 2000, mars2: 2500, mars4: 1000, prep: 750, numdep: 3000, elderly: 750, a00100: 5000000, state: state)
    zip3 = Zip.create(id: 80203, n1: 5100, mars1: 2000, mars2: 2500, mars4: 1000, prep: 750, numdep: 3000, elderly: 750, a00100: 5000000, state: state)
    visit zips_path

    expect(page).to have_content("Highest Income Zips:\n#{zip2.id}, #{zip2.mean_income}")
    expect(page).to have_link(zip1.id)
    expect(page).to have_content("Lowest Income Zips:\n#{zip1.id}, #{zip1.mean_income}")
    expect(page).to have_link(zip2.id)
    expect(page).to have_content("Highest Pop Zips:\n#{zip3.id}, #{zip3.n1}")
    expect(page).to have_link(zip2.id)
  end
end
