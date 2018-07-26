class SessionsController < ApplicationController
  def create
    # binding.pry
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.valid?
      session[:user_id] = user.id
      redirect_to user_path(user)
    end
  end
end
