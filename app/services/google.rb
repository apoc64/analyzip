class Google
  def initialize(location)
    if location == "New York"
      location = "New York State"
    end
    @location = location
  end


  def center
    return nil if invalid
    response["results"][0]["geometry"]["location"]
  end

  def bounds
    return failure_response if invalid
    response["results"][0]["geometry"]["bounds"]
  end

  def county
    return failure_response if invalid
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

  def invalid
    response["status"] == "ZERO_RESULTS"
  end
end
