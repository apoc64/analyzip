require 'rails_helper'

describe 'user navigates to county show from state' do
  it 'shows a list of county links' do
    state = create(:state)
    county1 = state.counties.create(county: 'abc')
    county2 = state.counties.create(county: 'def')
    county3 = County.create(county: 'ghi')

    allow_any_instance_of(Google).to receive(:center).and_return({'lat' => 0, 'lng' => 0})
    allow_any_instance_of(Google).to receive(:bounds).and_return({'northeast' => {'lat' => 0, 'lng' => 0}, 'southwest' => {'lat' => 0, 'lng' => 0}})

    visit state_path(state)

    expect(page).to have_link(county1.name)
    expect(page).to have_link(county2.name)
    expect(page).to_not have_link(county3.name)

    click_on county1.name

    expect(current_path).to eq(county_path(county1))
  end
end

describe 'user visits county show' do
  it 'shows county information' do
    allow_any_instance_of(Google).to receive(:center).and_return({'lat' => 0, 'lng' => 0})
    allow_any_instance_of(Google).to receive(:bounds).and_return({'northeast' => {'lat' => 0, 'lng' => 0}, 'southwest' => {'lat' => 0, 'lng' => 0}})

    state = create(:state, name: 'Colorado')
    county = state.counties.create(county: 'Denver County', measure_1_value: 5000, measure_2_value: 0.2356, measure_37_value: 0.0901, measure_45_value: 0.755, measure_14_value: 51.43, measure_24_value: 1234, measure_23_value: 0.0432, measure_44_value: 4.567, measure_125_value: 10.8, measure_126_value: 0, measure_60_value: 0.134, measure_129_value: 7.324, measure_85_value: 0.117, measure_58_value: 0.824, measure_141_value: 29.125, measure_142_value: 25.356)

    visit county_path(county)

    expect(page).to have_content('Denver County')
    expect(page).to have_content('Located in: Colorado')
    expect(page).to have_link('Colorado')
    expect(page).to have_content('Low Birth Weight: 9.01%')
    expect(page).to have_css('#map')
  end
end
