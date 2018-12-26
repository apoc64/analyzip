class StatePresenter < Presenter
  extend Forwardable
  def_delegator :@state, :abbreviation
  def_delegator :@state, :n1
  def_delegator :@state, :percent_single
  def_delegator :@state, :percent_joint
  def_delegator :@state, :percent_hoh
  def_delegator :@state, :percent_paid_prep
  def_delegator :@state, :percent_elderly
  def_delegator :@state, :mean_income
  def_delegator :@state, :zips
  # def_delegator :@state, :high_incomes
  # def_delegator :@state, :low_incomes
  def_delegator :@state, :counties

  def initialize(state_id, current_user)
    @state = State.find(state_id)
    set_user(current_user)

    google = Google.new(name)
    coords = google.center
    @lat = coords["lat"]
    @lng = coords["lng"]
    bounds = google.bounds
    @ne_lat = bounds["northeast"]["lat"]
    @ne_lng = bounds["northeast"]["lng"]
    @sw_lat = bounds["southwest"]["lat"]
    @sw_lng = bounds["southwest"]["lng"]

    @high_incomes = find_high_incomes
    @low_incomes = find_low_incomes
  end

  def name
    @state.name || @state.abbreviation
  end

  def average_dependents
    @state.average_dependents.round(2)
  end

  private

  def find_high_incomes
    rcp = RankingCardPresenter.new("Highest Incomes", "high-incomes")
    set_currency_collection(rcp, @state.high_incomes, ZipDecorator)
  end

  def find_low_incomes
    rcp = RankingCardPresenter.new("Lowest Incomes", "low-incomes")
    set_currency_collection(rcp, @state.low_incomes, ZipDecorator)
  end
end
