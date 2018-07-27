class RankingCardPresenter
  attr_reader :css_name,
              :title,
              :collection

  def initialize(title, css_name)
    @title = title
    @css_name = css_name
    @collection = []
  end

  def set_collection(source)
    @collection = source
    # binding.pry
    self
  end
end
