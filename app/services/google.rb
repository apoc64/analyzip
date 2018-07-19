class Google
  def zip_coords(zip_code)
    if Rails.application.credentials.google[:api_key]
      url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{zip_code}&key=#{Rails.application.credentials.google[:api_key]}"
      response = HTTParty.get(url)
    else
      response = {"status" => "ZERO_RESULTS"}
    end


    if response["status"] != "ZERO_RESULTS"
      # where ["types"].includes?"administrative_area_level_2"
      county = response["results"][0]["address_components"][2]["short_name"]
      # binding.pry
      response["results"][0]["geometry"]["location"]
      # ne se - size - viewport
    else
      # 81041
      puts "no results for #{zip_code}"
      {"lat" => 0, "lng" => 0}
    end
  end
end
