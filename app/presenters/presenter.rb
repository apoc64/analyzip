class Presenter
  extend Forwardable
  def_delegator :@user, :first_name
  def_delegator :@user, :log_action
  def_delegator :@user, :log_path

  attr_reader :user,
              :lat,
              :lng,
              :ne_lat,
              :ne_lng,
              :sw_lat,
              :sw_lng

  def set_user(current_user)
    page_user = current_user || User.new
    @user = UserDecorator.new(page_user)
  end

  def set_default_map
    @lat = 40
    @lng = -85
    @ne_lat = 50
    @ne_lng = -70
    @sw_lat = 30
    @sw_lng = -120
    @name = "United States"
    @map_name = "united%states"
  end

  def page_title
    "AnalyZip"
  end

  def page_description
    "Analyze socio-economic, health, tax and other data with maps for zip codes, states and other geographic entities."
  end
end
