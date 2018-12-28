class Zip < ApplicationRecord
  include IrsModelMethods
  validates_presence_of :n1

  belongs_to :state

  def code
    '%05d' % id
  end

  def self.highest_incomes
    select('zips.id, zips.a00100, zips.n1, (zips.a00100::float / zips.n1::float) AS raw_value').order('raw_value DESC').limit(10)
  end

  def self.lowest_incomes
    select('zips.id, zips.a00100, zips.n1, (zips.a00100::float / zips.n1::float) AS raw_value').order('raw_value ASC').limit(10)
  end

  def self.highest_pops
    select('id, n1 AS raw_value').order('raw_value DESC').limit(10)
  end
end
