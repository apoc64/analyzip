class ZipsIndexPresenter < Presenter
  def initialize(current_user)
    set_user(current_user)
    set_default_map
    @card1 = find_high_incomes
    @card2 = find_low_incomes
    @card3 = find_high_pops
  end

  def page_title
    'US Zip Codes - AnalyZip'
  end

  private

  def find_high_incomes
    cp = CardPresenter.new('Highest Incomes', 'card-1')
    set_currency_collection(cp, Zip.highest_incomes, ZipDecorator)
  end

  def find_low_incomes
    cp = CardPresenter.new('Lowest Incomes', 'card-2')
    set_currency_collection(cp, Zip.lowest_incomes, ZipDecorator)
  end

  def find_high_pops
    cp = CardPresenter.new('Highest Pops', 'card-3')
    set_delimiter_collection(cp, Zip.highest_pops, ZipDecorator)
  end
end
