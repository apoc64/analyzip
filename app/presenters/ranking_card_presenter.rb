class RankingCardPresenter
  attr_reader :css_name,
              :title,
              :collection

  def initialize(data)
    @css_name = ""
    @title = ""
    @collection = []
  end
end
