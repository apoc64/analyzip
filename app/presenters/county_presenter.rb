class CountyPresenter < Presenter

  def_delegator :@county, :name

  def_delegator :@county, :measure_24_value, :children_in_poverty
  def_delegator :@county, :measure_23_value, :unemployment
  def_delegator :@county, :measure_44_value, :income_inequality
  def_delegator :@county, :measure_125_value, :air_pollution
  def_delegator :@county, :measure_126_value, :water_violations
  def_delegator :@county, :measure_58_value, :percent_rural
  def_delegator :@county, :measure_141_value, :segregation_bw
  def_delegator :@county, :measure_142_value, :segregation_nw
  def_delegator :@county, :state

  attr_reader :county,
              :health_card_data

  def initialize(county_id, current_user)
    @county = County.find(county_id)
    set_user(current_user)

    @health_card_data = set_health_card_data

    google = Google.new(google_map_name)
    set_lat_lng(google)
  end

  def map_name
    "#{name}, #{state.abbreviation}"
  end

  def google_map_name
    "#{name},%#{state.abbreviation}"
  end

  private

  def set_health_card_data
    cp = RankingCardPresenter.new('Basic Health Data')
    cp.set_collection(basic_health_data)
  end

  def basic_health_data
    [
      DetailCardItem.new('Premature Death', @county.measure_1_value),
      DetailCardItem.new('Poor Health', @county.measure_2_value),
      DetailCardItem.new('Low Birth Weight', @county.measure_37_value).percent,
      DetailCardItem.new('STI Prevalence', @county.measure_45_value),
      DetailCardItem.new('Teen Births', @county.measure_14_value),
      DetailCardItem.new('Diabetes Prevalence', @county.measure_60_value),
      DetailCardItem.new('Infant Mortality', @county.measure_129_value),
      DetailCardItem.new('Uninsured', @county.measure_85_value)
    ]
  end

  def set_lat_lng(google)
    coords = google.center
    return nil unless coords
    @lat = coords['lat']
    @lng = coords['lng']
    bounds = google.bounds
    @ne_lat = bounds['northeast']['lat']
    @ne_lng = bounds['northeast']['lng']
    @sw_lat = bounds['southwest']['lat']
    @sw_lng = bounds['southwest']['lng']
  end
end
