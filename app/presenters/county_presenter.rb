class CountyPresenter < Presenter

  def_delegator :@county, :name
  def_delegator :@county, :state

  attr_reader :county,
              :health_card,
              :socio_economic_card

  def initialize(county_id, current_user)
    @county = County.find(county_id)
    set_user(current_user)

    @health_card = health_card_presenter
    @socio_economic_card = socio_economic_presenter

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

  def health_card_presenter
    cp = CardPresenter.new('Basic Health Data')
    cp.set_collection(basic_health_data)
  end

  def socio_economic_presenter
    cp = CardPresenter.new('Socio-Economic Data')
    cp.set_collection(socio_economic_data)
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

  def socio_economic_data
    [
      DetailCardItem.new('Children in Poverty', @county.measure_24_value),
      DetailCardItem.new('Unemployment', @county.measure_23_value),
      DetailCardItem.new('Income Inequality', @county.measure_44_value),
      DetailCardItem.new('Air Pollution', @county.measure_125_value),
      DetailCardItem.new('Water Violations', @county.measure_126_value),
      DetailCardItem.new('Percent Rural', @county.measure_58_value),
      DetailCardItem.new('Segregation B/W', @county.measure_141_value),
      DetailCardItem.new('Segregation NW/W', @county.measure_142_value)
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
