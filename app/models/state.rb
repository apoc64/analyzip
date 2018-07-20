class State < ApplicationRecord
  validates_presence_of :abbreviation
  has_many :zips

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

  def high_incomes
    zips.select('zips.id, zips.a00100, zips.n1, (zips.a00100 / zips.n1) AS income').order('income DESC').limit(10)
  end

  def low_incomes
    zips.select('zips.id, zips.a00100, zips.n1, (zips.a00100 / zips.n1) AS income').order('income ASC').limit(10)
  end
end
