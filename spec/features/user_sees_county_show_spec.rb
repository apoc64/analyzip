require 'rails_helper'

describe 'user navigates to county show from state' do
  it 'shows a list of county links' do
    state = create(:state)
    county1 = state.counties.create(county: 'abc')
    county2 = state.counties.create(county: 'def')
    county3 = County.create(county: 'ghi')

    allow_any_instance_of(Google).to receive(:center).and_return({"lat" => 0, "lng" => 0})
    allow_any_instance_of(Google).to receive(:bounds).and_return({"northeast" => {"lat" => 0, "lng" => 0}, "southwest" => {"lat" => 0, "lng" => 0}})

    visit state_path(state)

    expect(page).to have_link(county1.name)
    expect(page).to have_link(county2.name)
    expect(page).to_not have_link(county3.name)

    click_on county1.name

    expect(current_path).to eq(county_path(county1))
  end
end
