class UsersController < ApplicationController
  def show
    @presenter = UserPresenter.new(params[:id])
  end
end
