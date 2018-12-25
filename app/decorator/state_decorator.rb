class StateDecorator < SimpleDelegator
  include ActionView::Helpers::NumberHelper
  delegate :url_helpers, to: 'Rails.application.routes'

  def path
    url_helpers.state_path(self)
  end

  # Move to superclass, test exact dollars on zip, float SQL
  def link_name
    code
  end

  def set_currency
    @value = number_to_currency((raw_value * 1000), precision: 0)
  end

  def set_delimiter
    @value = number_with_delimiter(raw_value)
  end

  def value
    @value || raw_value
  end
end
