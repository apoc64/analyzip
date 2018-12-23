class ZipsIndexPresenter < Presenter
  attr_reader :high_incomes,
              :low_incomes,
              :highest_pops

  def initialize(current_user)
    set_user(current_user)
    set_default_map

    # move to model class methods
    @high_incomes = find_high_incomes

    @low_incomes = Zip.select('zips.id, zips.a00100, zips.n1, (zips.a00100 / zips.n1) AS income').order('income ASC').limit(10)
    @highest_pops = Zip.select('id, n1').order('n1 DESC').limit(10)
  end

  private

  def find_high_incomes
    rcp = RankingCardPresenter.new("Highest Incomes", "highest-incomes")
    set_currency_collection(rcp, Zip.highest_incomes)
  end

  def set_currency_collection(rcp, collection)
    zips = collection.map do |zip|
      zd = ZipDecorator.new(zip)
      zd.set_currency
      zd
    end
    rcp.set_collection(zips)
  end
end
