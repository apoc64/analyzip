class ZipPresenter
  attr_reader :code,
              :zip,
              :lat,
              :lng

  def initialize(zip_code)
    @code = zip_code
    @zip = Zip.find(zip_code)
    response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{@zip.id}&key=#{Rails.application.credentials.google[:api_key]}")
    coords = response["results"][0]["geometry"]["location"]
    @lat = coords["lat"]
    @lng = coords["lng"]
  end
end
