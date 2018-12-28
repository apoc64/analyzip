class Zip < ApplicationRecord
  validates_presence_of :n1

  belongs_to :state

  def code
    '%05d' % id
  end

  def single
    (mars1.to_f / n1.to_f)
  end

  def joint
    (mars2.to_f / n1.to_f)
  end

  def hoh
    (mars4.to_f / n1.to_f)
  end

  def paid_prep
    (prep.to_f / n1.to_f)
  end

  def average_dependents
    (numdep.to_f / n1.to_f)
  end

  def elderly_portion
    (elderly.to_f / n1.to_f)
  end

  def mean_income
    ((a00100.to_f / n1.to_f) * 1000).to_i
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
