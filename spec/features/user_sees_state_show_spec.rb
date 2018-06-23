require 'rails_helper'

describe 'user visits state show page' do
  it 'shows one state' do
    state = State.create(abbreviation: 'CO')
    zip1 = Zip.create(id: 80202, n1: 5000, state: state)
    zip2 = Zip.create(id: 80205, n1: 4000, state: state)

    visit state_path(state)

    expect(page).to have_content(state.abbreviation)
    expect(page).to have_link(zip1.id)
    expect(page).to have_link(zip2.id)
  end
end
