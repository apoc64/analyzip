class CountiesController < ApplicationController
  def show
    @presenter = CountyPresenter.new(params[:id])
  end

  def index
    @presenter = CountyIndexPresenter.new
  end
end
