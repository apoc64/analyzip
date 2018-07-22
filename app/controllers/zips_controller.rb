class ZipsController < ApplicationController
  def index
    @zips = ZipsIndexPresenter.new
  end

  def show
    # 81642
    @zip = ZipPresenter.new(params[:id])
  end
end
