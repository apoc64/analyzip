class Google
  def initialize(location)
    @location = location
  end


  def center
    if response["status"] != "ZERO_RESULTS"
      response["results"][0]["geometry"]["location"]
    else
      # 81041
      puts "no results for #{zip_code}"
      {"lat" => 0, "lng" => 0}
    end
  end

  def bounds
    response["results"][0]["geometry"]["bounds"]
  end

  def county
    response["results"][0]["address_components"].find do |component|
      component["types"].include?("administrative_area_level_2")
    end["short_name"]
  end

  private

  attr_reader :location

  def response
    @response ||= get_results
  end

  def get_results
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{Rails.application.credentials.google[:api_key]}"
    HTTParty.get(url)
    # Faraday, symbolize names
  end
end
