class Zip < ApplicationRecord
  validates_presence_of :n1

  belongs_to :state

  def code
    "%05d" % id
  end

  def percent_single
    ((mars1.to_f / n1.to_f) * 100).to_i
  end

  def percent_joint
    ((mars2.to_f / n1.to_f) * 100).to_i
  end

  def percent_hoh
    ((mars4.to_f / n1.to_f) * 100).to_i
  end

  def percent_paid_prep
    ((prep.to_f / n1.to_f) * 100).to_i
  end

  def average_dependents
    (numdep.to_f / n1.to_f)
  end

  def percent_elderly
    ((elderly.to_f / n1.to_f) * 100).to_i
  end

  def mean_income
    ((a00100.to_f / n1.to_f) * 1000).to_i
  end

  def self.highest_incomes
    Zip.select('zips.id, zips.a00100, zips.n1, (zips.a00100 / zips.n1) AS raw_value').order('raw_value DESC').limit(10)
  end

  def self.lowest_incomes
    Zip.select('zips.id, zips.a00100, zips.n1, (zips.a00100 / zips.n1) AS raw_value').order('raw_value ASC').limit(10)
  end
end
