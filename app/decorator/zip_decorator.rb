class ZipDecorator < SimpleDelegator
  include ActionView::Helpers::NumberHelper
  delegate :url_helpers, to: 'Rails.application.routes'

  def link_name
    code
  end

  def path
    url_helpers.zip_path(self)
  end

  def set_currency
    @value = number_to_currency(raw_value * 1000)
  end

  def value
    @value || raw_value
  end
end
