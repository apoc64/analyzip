class StateIndexPresenter
  attr_reader :high_incomes,
              :low_incomes,
              :highest_pops,
              :states,
              :lat,
              :lng,
              :ne_lat,
              :ne_lng,
              :sw_lat,
              :sw_lng,
              :name

  def initialize
    # move to model class methods
    @high_incomes = State.select('states.id, states.abbreviation, states.name, states.a00100, states.n1, (states.a00100 / states.n1) AS income').order('income DESC').limit(10)
    @low_incomes = State.select('states.id, states.name, states.abbreviation, states.a00100, states.n1, (states.a00100 / states.n1) AS income').order('income ASC').limit(10)
    @highest_pops = State.select('id, name, abbreviation, n1').order('n1 DESC').limit(10)
    @states = State.select('id, name, abbreviation')
    @lat = 40
    @lng = -85
    @ne_lat = 50
    @ne_lng = -70
    @sw_lat = 30
    @sw_lng = -120
    @name = "United States"
  end
end
# {"lat"=>37.09024, "lng"=>-95.712891}
# {"northeast"=>{"lat"=>71.5388001, "lng"=>-66.885417}, "southwest"=>{"lat"=>18.7763, "lng"=>170.5957}}
