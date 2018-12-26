class CountyDecorator < Decorator
  include ActionView::Helpers::NumberHelper
  delegate :url_helpers, to: 'Rails.application.routes'

  def link_name
    "#{name}, #{state.abbreviation}"
  end

  def path
    url_helpers.county_path(self)
  end
end
