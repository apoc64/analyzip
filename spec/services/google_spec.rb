require 'rails_helper'

describe 'Google service' do
  it 'returns coordinates of zip code' do
    google = Google.new(80205)
    response = google.center

    expect(response).to eq({
        "lat" => 39.7558119,
        "lng" => -104.9680914
    })
  end
end
