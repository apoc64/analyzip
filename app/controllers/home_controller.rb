class HomeController < ApplicationController
  def index
    @presenter = Presenter.new
    @presenter.set_user(current_user)
  end
end
