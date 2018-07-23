class StateIndexPresenter
  attr_reader :high_incomes,
              :low_incomes,
              :highest_pops,
              :states

  def initialize
    # move to model class methods
    @high_incomes = State.select('states.id, states.name, states.a00100, states.n1, (states.a00100 / states.n1) AS income').order('income DESC').limit(10)
    @low_incomes = State.select('states.id, states.name, states.a00100, states.n1, (states.a00100 / states.n1) AS income').order('income ASC').limit(10)
    @highest_pops = State.select('id, name, n1').order('n1 DESC').limit(10)
    @states = State.select('id, name, abbreviation')
  end
end
