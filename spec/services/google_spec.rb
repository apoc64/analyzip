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
    expect(bounds).to eq({"northeast" => {"lat"=>39.77992, "lng"=>-104.940483},
       "southwest" => {"lat"=>39.743461, "lng"=>-104.997182}})
    expect(county).to eq("Denver County")
  end

  it 'returns information of a state' do
    google = Google.new("Michigan")
    center = google.center
    bounds = google.bounds

    expect(center).to eq({"lat" => 44.3148443,
       "lng" => -85.60236429999999})
    expect(bounds).to eq({"northeast" => {"lat"=>48.3056044, "lng"=>-82.1229766},
       "southwest" => {"lat"=>41.696118, "lng"=>-90.4181358}})
  end

  it 'returns information for New York State, not City' do
    google = Google.new("New York")
    center = google.center
    bounds = google.bounds

    expect(center).to eq({"lat"=>43.2994285, "lng"=>-74.21793260000001})
    expect(bounds).to eq({"northeast"=>{"lat"=>45.015861, "lng"=>-71.777491}, "southwest"=>{"lat"=>40.4773991, "lng"=>-79.7625901}})
  end
end
