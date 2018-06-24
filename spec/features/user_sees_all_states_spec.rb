require 'rails_helper'

describe 'user visits states page' do
  it 'shows all states' do
    state1 = create(:state)
    state2 = State.create(abbreviation: 'CA')

    visit states_path

    expect(page).to have_link(state1.abbreviation)
    expect(page).to have_link(state2.abbreviation)
  end
end
