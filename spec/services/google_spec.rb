require 'rails_helper'

describe 'Google service' do
  xit 'returns coordinates of zip code' do
    zip_code = create(:zip).id

    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{zip_code}&key=#{Rails.application.credentials.google[:api_key]}"
    coords_response = File.open('./data/fixtures/google_coords.json')
    # coords_response = JSON.parse(json)
    # binding.pry
    stub_request(:get, url).to_return(status: 200, body: coords_response)

    response = Google.new.zip_coords(zip_code)

    expect(response).to eq({
                    "lat": 39.7541032,
                    "lng": -105.0002242
                })
  end
end
