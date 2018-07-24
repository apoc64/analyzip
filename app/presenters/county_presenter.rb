class CountyPresenter
  def initialize(county_id)
    @county = County.find(county_id)
  end
end
