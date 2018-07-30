class UserDecorator < SimpleDelegator
  include ActionView::Helpers::NumberHelper
  delegate :url_helpers, to: 'Rails.application.routes'

  def log_action
    if persisted?
      "Logout"
    else
      "Login"
    end
  end

  def log_path
    "/#{log_action}"
  end

  def user_action
    if persisted?
      "Profile"
    else
      "Sign Up"
    end
  end

  def current_user_path
    if persisted?
      "/users/#{id}"
    else
      "/Login"
    end
  end

  def fav_partial
    if persisted?
      "fav_add"
    else
      "fav_login"
    end
  end
end
