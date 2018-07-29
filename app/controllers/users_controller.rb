class UsersController < ApplicationController
  def show
    @presenter = UserPresenter.new(current_user)
  end
end
