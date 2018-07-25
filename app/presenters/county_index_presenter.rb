class CountyIndexPresenter
  attr_reader :most_premature_death,
              :most_low_birth_weight,
              :most_diabetes,
              :lat,
              :lng,
              :ne_lat,
              :ne_lng,
              :sw_lat,
              :sw_lng,
              :name,
              :map_name

  def initialize
    @most_premature_death = RankingCardPresenter.new(premature_deaths)
    @most_low_birth_weight = RankingCardPresenter.new(low_birth_weight)
    @most_diabetes = RankingCardPresenter.new(diabetes)

    # extract class: MapData - default is US ~~ serialize for db objects???
    @lat = 40
    @lng = -85
    @ne_lat = 50
    @ne_lng = -70
    @sw_lat = 30
    @sw_lng = -120
    @name = "United States"
    @map_name = "united%states"
  end

  private

  def premature_deaths
  end

  def low_birth_weight
  end

  def diabetes
  end

end
