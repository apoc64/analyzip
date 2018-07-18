require 'rails_helper'

describe 'Google service' do
  it 'returns coordinates of zip code' do
    # url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{zip_code}&key=#{Rails.application.credentials.google[:api_key]}"
    # coords_response = File.open('./data/fixtures/google_coords.json')
    # coords_response = JSON.parse(json)
    # stub_request(:get, url).to_return(status: 200, body: coords_response)

    response = Google.new.zip_coords(80205)
    # binding.pry

    expect(response).to eq({
                    "lat" => 39.7558119,
                    "lng" => -104.9680914
                })
  end
end
