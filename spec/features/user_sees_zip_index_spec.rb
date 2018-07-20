require 'rails_helper'

describe 'user visits zip index page' do
  it 'shows high and low income zips' do
    zip1 = create(:zip)
    zip2 = create(:zip_high_income)
    zip3 = create(:zip_high_pop)

    visit zips_path

    expect(page).to have_content("Highest Incomes:\n#{zip2.code}: $1,000,000")
    expect(page).to have_link(zip1.id)
    expect(page).to have_content("Lowest Incomes:\n#{zip1.code}: $200,000")
    expect(page).to have_link(zip2.id)
    expect(page).to have_content("Highest Pops:\n#{zip3.code}: 5,100")
    expect(page).to have_link(zip2.id)
  end
end
