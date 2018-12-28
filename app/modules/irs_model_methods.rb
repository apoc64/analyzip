module IrsModelMethods
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
    ((a00100.to_f / n1.to_f) * 1000)
  end
end
