class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.valid?
      session[:user_id] = user.id
      redirect_to user_path(user)
    end
  end

  def destroy
    reset_session
    redirect_to '/'
  end

  def new
    @presenter = UserPresenter.new(current_user)
  end
end
