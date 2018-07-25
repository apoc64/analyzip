class CountyPresenter
  extend Forwardable
  def_delegator :@county, :name
  def_delegator :@county, :measure_1_value, :premature_death
  def_delegator :@county, :measure_2_value, :poor_health
  # def_delegator :@county, :measure_37_value, :low_birth_weight
  def_delegator :@county, :measure_45_value, :sti_prevalence
  def_delegator :@county, :measure_14_value, :teen_births
  def_delegator :@county, :measure_60_value, :diabetes_prevalence
  def_delegator :@county, :measure_129_value, :infant_mortality
  def_delegator :@county, :measure_85_value, :uninsured
  def_delegator :@county, :state

  attr_reader :county,
              :lat,
              :lng,
              :ne_lat,
              :ne_lng,
              :sw_lat,
              :sw_lng

  def initialize(county_id)
    @county = County.find(county_id)
    google = Google.new(google_map_name)
    set_lat_lng(google)
    # binding.pry
  end

  def low_birth_weight
    (@county.measure_37_value.to_f * 100).round(2)
  end

  def map_name
    "#{name}, #{state.abbreviation}"
  end

  def google_map_name
    "#{name},%#{state.abbreviation}"
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
