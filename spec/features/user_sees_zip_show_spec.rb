require 'rails_helper'

describe 'user visits zip show page' do
  it 'shows zip info' do
    zip = create(:zip)

    allow_any_instance_of(Google).to receive(:center).and_return({'lat' => 0, 'lng' => 0})
    allow_any_instance_of(Google).to receive(:bounds).and_return({'northeast' => {'lat' => 0, 'lng' => 0}, 'southwest' => {'lat' => 0, 'lng' => 0}})

    visit zip_path(zip.code)

    expect(page).to have_content(zip.id)
    expect(page).to have_link(zip.state.abbreviation)
    expect(page).to have_content('No. of Returns: 5,000')
    expect(page).to have_content("Percent Single: #{((zip.mars1.to_f / zip.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Percent Joint File: #{((zip.mars2.to_f / zip.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Percent HOH: #{((zip.mars4.to_f / zip.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Percent Paid Prep: #{((zip.prep.to_f / zip.n1.to_f) * 100).to_i}")
    expect(page).to have_content("Avg Dependents: #{(zip.numdep.to_f / zip.n1.to_f)}")
    expect(page).to have_content("Percent Elderly: #{((zip.elderly.to_f / zip.n1.to_f) * 100).to_i}")
    expect(page).to have_content('Avg Income: $200,000')

    expect(page).to_not have_content('Add to my favorites')

    click_on 'Login or Sign Up to add this zip to my favorites'

    expect(current_path).to eq('/Login')
  end

  # cannot have transctional db with async js
  # require 'capybara/poltergeist'
  it 'lets a logged in user favorite a zip code' do
    # , js: true, driver: :poltergeist do
    zip = create(:zip)
    user = User.create(first_name: 'bob', last_name: 'bobber', email: 'bob@bob.bob')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    allow_any_instance_of(Google).to receive(:center).and_return({'lat' => 0, 'lng' => 0})
    allow_any_instance_of(Google).to receive(:bounds).and_return({'northeast' => {'lat' => 0, 'lng' => 0}, 'southwest' => {'lat' => 0, 'lng' => 0}})

    visit zip_path(zip.code)

    expect(page).to_not have_link('Login or Sign Up to add this zip to my favorites')
    # fill_in 'user_zip[comment]', with: 'I like this zip'
    # expect(page).to have_content("Add to my favorites")
    # click_on "Add to my favorites"
    # visit user_path(user)
    # expect(page).to have_link(zip.code)
    # expect(page).to have_content('I like this zip')
  end

  # it 'lets a logged in user delete a favorite'
end
