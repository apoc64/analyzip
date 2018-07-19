require 'rails_helper'

describe 'Google service' do
  it 'returns information of a zip code' do
    google = Google.new(80205)
    center = google.center
    bounds = google.bounds
    county = google.county

    expect(center).to eq({
        "lat" => 39.7558119,
        "lng" => -104.9680914
    })
    expect(bounds).to eq("{\"northeast\":{\"lat\":39.77992,\"lng\":-104.940483},\"southwest\":{\"lat\":39.743461,\"lng\":-104.997182}}")
    expect(county).to eq("Denver County")
  end

  it 'returns information of a state' do
    google = Google.new("Michigan")
    center = google.center
    bounds = google.bounds

    expect(center).to eq({"lat" => 44.3148443,
       "lng" => -85.60236429999999})
    expect(bounds).to eq("{\"northeast\":{\"lat\":48.3060628,\"lng\":-82.1229709},\"southwest\":{\"lat\":41.696118,\"lng\":-90.4181358}}")
  end
end
