class StatesController < ApplicationController
  def index
    @states = State.all
  end

  def show
    @state = StatePresenter.new(params[:id])
  end
end
