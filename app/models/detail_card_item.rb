class DetailCardItem
  include ActionView::Helpers::NumberHelper

  attr_reader :name,
              :value

  def initialize(name, value)
    @name = name
    @value = value
  end

  def percent
    @value = "#{(@value.to_f * 100).round(2)}%"
    self
  end

  def round(places)
    @value = @value.round(places)
    self
  end

  def delimiter
    @value = number_with_delimiter(@value)
    self
  end

  def currency
    @value = number_to_currency(@value)
    self
  end
end
