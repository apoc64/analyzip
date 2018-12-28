class DetailCardItem
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
  end

  def delimiter
  end

  def currency
  end
end
