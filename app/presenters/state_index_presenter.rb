class StateIndexPresenter < Presenter
  attr_reader :high_incomes,
              :low_incomes,
              :highest_pops,
              :states,
              :name

  def initialize(current_user)
    # move to model class methods
    set_user(current_user)
    @high_incomes = find_high_incomes
    State.select('states.id, states.abbreviation, states.name, states.a00100, states.n1, (states.a00100 / states.n1) AS income').order('income DESC').limit(10)
    @low_incomes = State.select('states.id, states.name, states.abbreviation, states.a00100, states.n1, (states.a00100 / states.n1) AS income').order('income ASC').limit(10)
    @highest_pops = State.select('id, name, abbreviation, n1').order('n1 DESC').limit(10)
    @states = State.select('id, name, abbreviation')

    set_default_map
  end

  def page_title
    "All States - AnalyZip"
  end

  private

  def find_high_incomes
    rcp = RankingCardPresenter.new("Highest Incomes", "high-incomes")
    set_currency_collection(rcp, State.highest_incomes)
  end

  def set_currency_collection(rcp, collection)
    states = collection.map do |zip|
      sd = StateDecorator.new(zip)
      sd.set_currency
      sd
    end
    rcp.set_collection(states)
  end
end
