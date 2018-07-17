class Google
  def zip_coords(zip_code)
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{zip_code}&key=#{Rails.application.credentials.google[:api_key]}"
    response = HTTParty.get(url)
    # binding.pry
    response["results"][0]["geometry"]["location"]
  end
end
