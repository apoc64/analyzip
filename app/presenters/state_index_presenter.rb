class StateIndexPresenter < Presenter
  attr_reader :high_incomes,
              :low_incomes,
              :highest_pops,
              :states,
              :name

  def initialize(current_user)
    # move to model class methods, SQL floats/tests
    set_user(current_user)
    @high_incomes = find_high_incomes
    @low_incomes = find_low_incomes
    @highest_pops = find_high_pops
    @states = State.select('id, name, abbreviation')

    set_default_map
  end

  def page_title
    "All States - AnalyZip"
  end

  private

  def find_high_incomes
    rcp = RankingCardPresenter.new("Highest Incomes", "high-incomes")
    set_currency_collection(rcp, State.highest_incomes, StateDecorator)
  end

  def find_low_incomes
    rcp = RankingCardPresenter.new("Lowest Incomes", "low-incomes")
    set_currency_collection(rcp, State.lowest_incomes, StateDecorator)
  end

  def find_high_pops
    rcp = RankingCardPresenter.new("Highest Pops", "high-populations")
    set_delimiter_collection(rcp, State.highest_pops, StateDecorator)
  end
end
