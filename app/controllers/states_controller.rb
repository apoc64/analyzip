class StatesController < ApplicationController
  def index
    @presenter = StateIndexPresenter.new
  end

  def show
    @state = StatePresenter.new(params[:id])
  end
end
