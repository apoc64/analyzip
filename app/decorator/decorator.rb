class Decorator < SimpleDelegator
  include ActionView::Helpers::NumberHelper
  delegate :url_helpers, to: 'Rails.application.routes'

  def link_name
    code
  end

  def set_currency
    @value = number_to_currency((raw_value * 1000), precision: 0)
  end

  def set_delimiter
    @value = number_with_delimiter(raw_value)
  end

  def set_rounded
    @value = number_with_delimiter(raw_value.round)
  end

  def set_percent
    @value = "#{(raw_value * 100).round(2)}%"
  end

  def value
    @value || raw_value
  end
end
