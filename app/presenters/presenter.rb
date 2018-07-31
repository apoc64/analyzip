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
              :high_incomes,
              :low_incomes,
              :premature_deaths,
              :low_birth_weights,
              :diabetes_prevalences

  def set_user(current_user)
    page_user = current_user || User.new
    @user = UserDecorator.new(page_user)
    @high_incomes = []
    @low_incomes = []
    @premature_deaths = RankingCardPresenter.new("", "")
    @low_birth_weights = RankingCardPresenter.new("", "")
    @diabetes_prevalences = RankingCardPresenter.new("", "")
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
