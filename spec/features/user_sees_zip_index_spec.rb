require 'rails_helper'

describe 'user visits zip index page' do
  it 'shows high and low income zips' do
    zip1 = create(:zip)
    zip2 = create(:zip_high_income)
    zip3 = create(:zip_high_pop)

    visit zips_path

    expect(page).to have_content("Highest Income Zips:\n#{zip2.id}, #{zip2.mean_income}")
    expect(page).to have_link(zip1.id)
    expect(page).to have_content("Lowest Income Zips:\n#{zip1.id}, #{zip1.mean_income}")
    expect(page).to have_link(zip2.id)
    expect(page).to have_content("Highest Pop Zips:\n#{zip3.id}, #{zip3.n1}")
    expect(page).to have_link(zip2.id)
  end
end
