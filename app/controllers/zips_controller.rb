class ZipsController < ApplicationController
  def index
    @zips = ZipsIndexPresenter.new
  end

  def show
    @zip = ZipPresenter.new(params[:id])
  end
end
