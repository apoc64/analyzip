class ZipsController < ApplicationController
  def index
    @zips = ZipsIndexPresenter.new(current_user)
  end

  def show
    # 81642
    @zip = ZipPresenter.new(params[:id], current_user)
  end
end
