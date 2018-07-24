class CountiesController < ApplicationController
  def show
    county_id = params[:id]
    @presenter = CountyPresenter.new(county_id)
  end
end
