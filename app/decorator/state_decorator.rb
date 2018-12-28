class StateDecorator < Decorator
  def path
    url_helpers.state_path(self)
  end
end
