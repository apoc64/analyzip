class ZipsIndexPresenter < Presenter
  attr_reader :high_incomes,
              :low_incomes,
              :highest_pops

  def initialize(current_user)
    set_user(current_user)
    set_default_map

    @high_incomes = find_high_incomes
    @low_incomes = find_low_incomes
    @highest_pops = Zip.select('id, n1').order('n1 DESC').limit(10)
  end

  private

  def find_high_incomes
    rcp = RankingCardPresenter.new("Highest Incomes", "high-incomes")
    set_currency_collection(rcp, Zip.highest_incomes)
  end

  def find_low_incomes
    rcp = RankingCardPresenter.new("Lowest Incomes", "low-incomes")
    set_currency_collection(rcp, Zip.lowest_incomes)
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
