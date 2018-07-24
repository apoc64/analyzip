class StatePresenter
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
  def_delegator :@state, :high_incomes
  def_delegator :@state, :low_incomes
  def_delegator :@state, :counties

  attr_reader :lat,
              :lng,
              :ne_lat,
              :ne_lng,
              :sw_lat,
              :sw_lng

  def initialize(state_id)
    @state = State.find(state_id)
    google = Google.new(name)
    coords = google.center
    @lat = coords["lat"]
    @lng = coords["lng"]
    bounds = google.bounds
    @ne_lat = bounds["northeast"]["lat"]
    @ne_lng = bounds["northeast"]["lng"]
    @sw_lat = bounds["southwest"]["lat"]
    @sw_lng = bounds["southwest"]["lng"]
  end

  def name
    @state.name || @state.abbreviation
  end

  def average_dependents
    @state.average_dependents.round(2)
  end
end
