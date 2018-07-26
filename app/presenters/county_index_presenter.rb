class CountyIndexPresenter
  attr_reader :premature_death,
              :low_birth_weight,
              :diabetes,
              :lat,
              :lng,
              :ne_lat,
              :ne_lng,
              :sw_lat,
              :sw_lng,
              :name,
              :map_name

  def initialize
    @premature_death = find_premature_deaths
    @low_birth_weight = find_low_birth_weight
    @diabetes = find_diabetes

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

  def find_premature_deaths
    rcp = RankingCardPresenter.new("Most Premature Death", "premature-death")
    set_rounded_collection(rcp, County.premature_death)
  end

  def find_low_birth_weight
    rcp = RankingCardPresenter.new("Most Low Birth Weight", "low-birth-weight")
    set_percent_collection(rcp, County.low_birth_weight)
  end

  def find_diabetes
    rcp = RankingCardPresenter.new("Most Diabetes", "diabetes")
    set_percent_collection(rcp, County.diabetes)
  end

  # def set_collection(rcp, collection)
  #   counties = collection.map do |county|
  #     CountyDecorator.new(county)
  #   end
  #   rcp.set_collection(counties)
  # end

  def set_percent_collection(rcp, collection)
    counties = collection.map do |county|
      cd = CountyDecorator.new(county)
      cd.set_percent
      cd
    end
    rcp.set_collection(counties)
  end

  def set_rounded_collection(rcp, collection)
    counties = collection.map do |county|
      cd = CountyDecorator.new(county)
      cd.set_rounded
      cd
    end
    rcp.set_collection(counties)
  end
end
