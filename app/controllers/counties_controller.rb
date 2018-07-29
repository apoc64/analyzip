class CountiesController < ApplicationController
  def show
    @presenter = CountyPresenter.new(params[:id], current_user)
  end

  def index
    @presenter = CountyIndexPresenter.new(current_user)
  end
end
