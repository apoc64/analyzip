class ZipPresenter < Presenter
  # extend Forwardable
  def_delegator :@zip, :n1
  def_delegator :@zip, :percent_single
  def_delegator :@zip, :percent_joint
  def_delegator :@zip, :percent_hoh
  def_delegator :@zip, :percent_paid_prep
  def_delegator :@zip, :percent_elderly
  def_delegator :@zip, :mean_income
  def_delegator :@zip, :state
  def_delegator :@zip, :code

  attr_reader :zip
              # :lat,
              # :lng,
              # :ne_lat,
              # :ne_lng,
              # :sw_lat,
              # :sw_lng

  def initialize(zip_code, current_user)
    @zip = Zip.find(zip_code)
    set_user(current_user)

    google = Google.new(zip.code)
    set_lat_lng(google)
  end

  def state_name
    @zip.state.name || @zip.state.abbreviation
  end

  def average_dependents
    @zip.average_dependents.round(2)
  end

  private

  def set_lat_lng(google)
    coords = google.center
    return nil unless coords
    @lat = coords["lat"]
    @lng = coords["lng"]
    bounds = google.bounds
    @ne_lat = bounds["northeast"]["lat"]
    @ne_lng = bounds["northeast"]["lng"]
    @sw_lat = bounds["southwest"]["lat"]
    @sw_lng = bounds["southwest"]["lng"]
  end
end
