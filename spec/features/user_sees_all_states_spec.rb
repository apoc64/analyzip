require 'rails_helper'

describe 'user visits states page' do
  it 'shows all states' do
    state1 = create(:state, name: 'Colorado')
    state2 = create(:state, abbreviation: 'CA', name: 'California')

    allow_any_instance_of(Google).to receive(:center).and_return({"lat" => 0, "lng" => 0})
    allow_any_instance_of(Google).to receive(:bounds).and_return({"northeast" => {"lat" => 0, "lng" => 0}, "southwest" => {"lat" => 0, "lng" => 0}})

    visit states_path

    expect(page).to have_link(state1.name)
    expect(page).to have_link(state2.name)
  end

  it 'shows state information' do
    state1 = create(:state, name: 'hello')
    state2 = create(:state, abbreviation: 'HI', name: 'howdy', a00100: 5000000)
    state3 = create(:state, abbreviation: 'HP', name: 'aloha', n1: 18000, a00100: 4500000)

    allow_any_instance_of(Google).to receive(:center).and_return({"lat" => 0, "lng" => 0})
    allow_any_instance_of(Google).to receive(:bounds).and_return({"northeast" => {"lat" => 0, "lng" => 0}, "southwest" => {"lat" => 0, "lng" => 0}})

    visit states_path

    expect(page).to have_content("Highest Incomes:\n#{state2.name}: $333,333")
    expect(page).to have_link(state1.name)
    expect(page).to have_content("Lowest Incomes:\n#{state1.name}: $200,000")
    expect(page).to have_link(state2.name)
    expect(page).to have_content("Highest Pops:\n#{state3.name}: 18,000")
    expect(page).to have_link(state3.name)
  end
end
