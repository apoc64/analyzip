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

  def initialize(state_id)
    @state = State.find(state_id)
    # map call
  end

  def name
    @state.name || @state.abbreviation
  end

  def average_dependents
    @state.average_dependents.round(2)
  end

  def high_incomes
    @state.zips.select('zips.id, zips.a00100, zips.n1, (zips.a00100 / zips.n1) AS income').order('income DESC').limit(10)
  end

  def low_incomes
    @state.zips.select('zips.id, zips.a00100, zips.n1, (zips.a00100 / zips.n1) AS income').order('income ASC').limit(10)
  end
end
