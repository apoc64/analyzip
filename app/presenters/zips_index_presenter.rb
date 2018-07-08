class ZipsIndexPresenter
  attr_reader :high_incomes,
              :low_incomes,
              :highest_pops

  def initialize
    @high_incomes = Zip.select('zips.id, zips.a00100, zips.n1, (zips.a00100 / zips.n1) AS income').order('income DESC').limit(10)
    @low_incomes = Zip.select('zips.id, zips.a00100, zips.n1, (zips.a00100 / zips.n1) AS income').order('income ASC').limit(10)
    @highest_pops = Zip.select('id, n1').order('n1 DESC').limit(10)
  end

end
