class ZipsIndexPresenter < Presenter
  attr_reader :high_incomes,
              :low_incomes,
              :highest_pops

  def initialize(current_user)
    set_user(current_user)
    set_default_map

    @high_incomes = find_high_incomes
    @low_incomes = find_low_incomes
    @highest_pops = find_high_pops
  end

  private

  def find_high_incomes
    rcp = RankingCardPresenter.new("Highest Incomes", "high-incomes")
    set_currency_collection(rcp, Zip.highest_incomes, ZipDecorator)
  end

  def find_low_incomes
    rcp = RankingCardPresenter.new("Lowest Incomes", "low-incomes")
    set_currency_collection(rcp, Zip.lowest_incomes, ZipDecorator)
  end

  def find_high_pops
    rcp = RankingCardPresenter.new("Highest Pops", "highest-pops")
    set_delimiter_collection(rcp, Zip.highest_pops, ZipDecorator)
  end
end
