class ZipsController < ApplicationController
  def index
    @presenter = ZipsIndexPresenter.new(current_user)
  end

  def show
    # 81642
    @presenter = ZipPresenter.new(params[:id], current_user)
  end
end
