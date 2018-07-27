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
end
