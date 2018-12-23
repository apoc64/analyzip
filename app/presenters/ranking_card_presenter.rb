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
    self
  end

  def each(*)
    @collection.each do |object|
      yield(object)
    end
  end
end
