class Presenter
  extend Forwardable
  def_delegator :@user, :first_name
  def_delegator :@user, :log_action
  def_delegator :@user, :log_path
  def_delegator :@user, :user_action
  def_delegator :@user, :current_user_path
  def_delegator :@user, :fav_partial

  attr_reader :user,
              :lat,
              :lng,
              :ne_lat,
              :ne_lng,
              :sw_lat,
              :sw_lng,
              :map_name,
              :geo_unit

  def set_user(current_user)
    page_user = current_user || User.new
    @user = UserDecorator.new(page_user)
  end

  def set_location(location, geo_unit = 'zip codes')
    google = Google.new(location)
    coords = google.center
    return nil unless coords
    @lat = coords['lat']
    @lng = coords['lng']
    bounds = google.bounds
    # 88024
    return nil unless bounds
    @ne_lat = bounds['northeast']['lat']
    @ne_lng = bounds['northeast']['lng']
    @sw_lat = bounds['southwest']['lat']
    @sw_lng = bounds['southwest']['lng']
    @geo_unit = geo_unit
    @map_name = location
  end

  def card1
    @card1 ||= CardPresenter.new('')
  end

  def card2
    @card2 ||= CardPresenter.new('')
  end

  def card3
    @card3 ||= CardPresenter.new('')
  end

  def set_default_map(geo_unit = 'zip codes')
    @lat = 40
    @lng = -85
    @ne_lat = 50
    @ne_lng = -70
    @sw_lat = 30
    @sw_lng = -120
    @map_name = 'the United States'
    @geo_unit = geo_unit
  end

  def page_title
    'AnalyZip'
  end

  def page_description
    'Analyze socio-economic, health, tax and other data with maps for zip codes, states and other geographic entities.'
  end

  def set_percent_collection(rcp, collection, decorator_class)
    items = collection.map do |item|
      decorator = decorator_class.new(item)
      decorator.set_percent
      decorator
    end
    rcp.set_collection(items)
  end

  def set_rounded_collection(rcp, collection, decorator_class)
    items = collection.map do |item|
      decorator = decorator_class.new(item)
      decorator.set_rounded
      decorator
    end
    rcp.set_collection(items)
  end

  def set_currency_collection(rcp, collection, decorator_class)
    items = collection.map do |item|
      decorator = decorator_class.new(item)
      decorator.set_currency
      decorator
    end
    rcp.set_collection(items)
  end

  def set_delimiter_collection(rcp, collection, decorator_class)
    items = collection.map do |item|
      decorator = decorator_class.new(item)
      decorator.set_delimiter
      decorator
    end
    rcp.set_collection(items)
  end

  def basic_irs_data(location)
    [
      DetailCardItem.new('No. of Returns', location.n1).delimiter,
      DetailCardItem.new('Percent Single', location.single).percent,
      DetailCardItem.new('Percent Joint File', location.joint).percent,
      DetailCardItem.new('Percent HOH', location.hoh).percent,
      DetailCardItem.new('Percent Paid Prep', location.paid_prep).percent,
      DetailCardItem.new('Avg Dependents', location.average_dependents).round(2),
      DetailCardItem.new('Percent Elderly', location.elderly_portion).percent,
      DetailCardItem.new('Avg Income', location.mean_income).currency
    ]
  end
end
