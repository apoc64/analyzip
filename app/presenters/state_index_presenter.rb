class StateIndexPresenter < Presenter
  attr_reader :states,
              :name

  def initialize(current_user)
    set_user(current_user)
    @high_incomes = find_high_incomes
    @low_incomes = find_low_incomes
    @highest_pops = find_high_pops
    @states = State.select('id, name, abbreviation')

    set_default_map
  end

  def page_title
    'All States - AnalyZip'
  end

  private

  def find_high_incomes
    cp = CardPresenter.new('Highest Incomes', 'high-incomes')
    set_currency_collection(cp, State.highest_incomes, StateDecorator)
  end

  def find_low_incomes
    cp = CardPresenter.new('Lowest Incomes', 'low-incomes')
    set_currency_collection(cp, State.lowest_incomes, StateDecorator)
  end

  def find_high_pops
    cp = CardPresenter.new('Highest Pops', 'highest-pops')
    set_delimiter_collection(cp, State.highest_pops, StateDecorator)
  end
end
