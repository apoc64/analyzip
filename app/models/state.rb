class State < ApplicationRecord
  include IrsModelMethods
  validates_presence_of :abbreviation
  has_many :zips
  has_many :counties

  def high_incomes
    zips.select('zips.id, zips.a00100, zips.n1, (zips.a00100::float / zips.n1::float) AS raw_value').order('raw_value DESC').limit(10)
  end

  def low_incomes
    zips.select('zips.id, zips.a00100, zips.n1, (zips.a00100::float / zips.n1::float) AS raw_value').order('raw_value ASC').limit(10)
  end

  def self.highest_incomes
    select('states.id, states.abbreviation, states.name, states.a00100, states.n1, (states.a00100::float / states.n1::float) AS raw_value').order('raw_value DESC').limit(10)
  end

  def self.lowest_incomes
    select('states.id, states.name, states.abbreviation, states.a00100, states.n1, (states.a00100::float / states.n1::float) AS raw_value').order('raw_value ASC').limit(10)
  end

  def self.highest_pops
    select('id, name, abbreviation, n1 AS raw_value').order('raw_value DESC').limit(10)
  end

  # for income card polymorphism
  def code
    name
  end

end
