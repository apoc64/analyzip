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
  end
end
