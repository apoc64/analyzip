class CountyPresenter < Presenter

  def_delegator :@county, :name
  def_delegator :@county, :measure_1_value, :premature_death
  def_delegator :@county, :measure_2_value, :poor_health
  def_delegator :@county, :measure_45_value, :sti_prevalence
  def_delegator :@county, :measure_14_value, :teen_births
  def_delegator :@county, :measure_60_value, :diabetes_prevalence
  def_delegator :@county, :measure_129_value, :infant_mortality
  def_delegator :@county, :measure_85_value, :uninsured
  def_delegator :@county, :measure_24_value, :children_in_poverty
  def_delegator :@county, :measure_23_value, :unemployment
  def_delegator :@county, :measure_44_value, :income_inequality
  def_delegator :@county, :measure_125_value, :air_pollution
  def_delegator :@county, :measure_126_value, :water_violations
  def_delegator :@county, :measure_58_value, :percent_rural
  def_delegator :@county, :measure_141_value, :segregation_bw
  def_delegator :@county, :measure_142_value, :segregation_nw
  def_delegator :@county, :state

  attr_reader :county

  def initialize(county_id, current_user)
    @county = County.find(county_id)
    set_user(current_user)

    google = Google.new(google_map_name)
    set_lat_lng(google)
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
