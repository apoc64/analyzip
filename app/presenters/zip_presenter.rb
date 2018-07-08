class ZipPresenter
  attr_reader :code,
              :zip,
              :lat,
              :lng

  def initialize(zip_code)
    @code = zip_code
    @zip = Zip.find(zip_code)
    coords = Google.new.zip_coords(zip_code)
    @lat = coords["lat"]
    @lng = coords["lng"]
  end
end
