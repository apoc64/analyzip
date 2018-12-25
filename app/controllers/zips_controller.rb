class ZipsController < ApplicationController
  def index
    @presenter = ZipsIndexPresenter.new(current_user)
    # render streams: true # yield, content_for... in layout
  end

  def show
    # 81642
    @presenter = ZipPresenter.new(params[:id], current_user)
  end
end
