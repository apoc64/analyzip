class StatesController < ApplicationController
  def index
    @states = State.all
  end

  def show
    @state = State.find(params[:id])
    @zips = Zip.where(state: @state)
    # binding.pry
  end
end
