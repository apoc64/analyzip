class StatesController < ApplicationController
  def index
    @presenter = StateIndexPresenter.new(current_user)
  end

  def show
    @state = StatePresenter.new(params[:id], current_user)
  end
end
