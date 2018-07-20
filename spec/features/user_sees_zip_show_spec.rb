require 'rails_helper'

describe 'user visits zip show page' do
  it 'shows zip info' do
    # use web mock
    zip = create(:zip)

    allow_any_instance_of(Google).to receive(:center).and_return({"lat" => 0, "lng" => 0})
    allow_any_instance_of(Google).to receive(:bounds).and_return({"northeast" => {"lat" => 0, "lng" => 0}, "southwest" => {"lat" => 0, "lng" => 0}})

    visit zip_path(zip)

    expect(page).to have_content(zip.id)
    expect(page).to have_link(zip.state.abbreviation)
    expect(page).to have_content("No. of Returns: 5,000")
    expect(page).to have_content("Percent Single: #{((zip.mars1.to_f / zip.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Percent Joint File: #{((zip.mars2.to_f / zip.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Percent HOH: #{((zip.mars4.to_f / zip.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Percent Paid Prep: #{((zip.prep.to_f / zip.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Avg No. Dependents: #{(zip.numdep.to_f / zip.n1.to_f)}")
    expect(page).to have_content("Percent Elderly: #{((zip.elderly.to_f / zip.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Avg Income: $200,000")
  end
end
