class CountyIndexPresenter < Presenter

  attr_reader :premature_death,
              :low_birth_weight,
              :diabetes,
              :name

  def initialize(current_user)
    set_user(current_user)
    @premature_deaths = find_premature_deaths
    @low_birth_weights = find_low_birth_weight
    @diabetes_prevalences = find_diabetes

    set_default_map
  end

  private

  def find_premature_deaths
    rcp = RankingCardPresenter.new('Most Premature Death', 'premature-death')
    set_rounded_collection(rcp, County.premature_death, CountyDecorator)
  end

  def find_low_birth_weight
    rcp = RankingCardPresenter.new('Most Low Birth Weight', 'low-birth-weight')
    set_percent_collection(rcp, County.low_birth_weight, CountyDecorator)
  end

  def find_diabetes
    rcp = RankingCardPresenter.new('Most Diabetes', 'diabetes')
    set_percent_collection(rcp, County.diabetes, CountyDecorator)
  end
end
