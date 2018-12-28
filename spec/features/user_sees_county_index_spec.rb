require 'rails_helper'

describe 'user visits county show' do
  it 'shows county information' do
    allow_any_instance_of(Google).to receive(:center).and_return({'lat' => 0, 'lng' => 0})
    allow_any_instance_of(Google).to receive(:bounds).and_return({'northeast' => {'lat' => 0, 'lng' => 0}, 'southwest' => {'lat' => 0, 'lng' => 0}})

    state = create(:state, name: 'Colorado')
    state2 = create(:state, name: 'California')
    county1 = state.counties.create(county: 'Denver County', measure_1_value: 5000, measure_2_value: 0.2356, measure_37_value: 0.0901, measure_45_value: 0.755, measure_14_value: 51.43, measure_24_value: 1234, measure_23_value: 0.0432, measure_44_value: 4.567, measure_125_value: 10.8, measure_126_value: 0, measure_60_value: 0.134, measure_129_value: 7.324, measure_85_value: 0.117, measure_58_value: 0.824, measure_141_value: 29.125, measure_142_value: 25.356)
    county2 = state.counties.create(county: 'Arapaho County', measure_1_value: 4000, measure_2_value: 0.2356, measure_37_value: 0.1001, measure_45_value: 0.755, measure_14_value: 51.43, measure_24_value: 1234, measure_23_value: 0.0432, measure_44_value: 4.567, measure_125_value: 10.8, measure_126_value: 0, measure_60_value: 0.134, measure_129_value: 7.324, measure_85_value: 0.117, measure_58_value: 0.824, measure_141_value: 29.125, measure_142_value: 25.356)
    county3 = state2.counties.create(county: 'Los Angeles County', measure_1_value: 4000, measure_2_value: 0.2356, measure_37_value: 0.0901, measure_45_value: 0.755, measure_14_value: 51.43, measure_24_value: 1234, measure_23_value: 0.0432, measure_44_value: 4.567, measure_125_value: 10.8, measure_126_value: 0, measure_60_value: 0.154, measure_129_value: 7.324, measure_85_value: 0.117, measure_58_value: 0.824, measure_141_value: 29.125, measure_142_value: 25.356)

    visit counties_path

    expect(page).to have_content("Most Premature Death:\n#{county1.name}, #{state.abbreviation}: 5,000")
    expect(page).to have_link(county1.name)
    expect(page).to have_content("Most Low Birth Weight:\n#{county2.name}, #{state.abbreviation}: 10.01%")
    expect(page).to have_link(county2.name)
    expect(page).to have_content("Most Diabetes:\n#{county3.name}, #{state.abbreviation}: 15.4%")
    expect(page).to have_link(county3.name)

  end
end
