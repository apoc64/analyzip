class CardPresenter
  attr_reader :css_name,
              :title

  def initialize(title, css_name = 'base-card')
    @title = title
    @css_name = css_name
  end

  def set_collection(source)
    @collection = source
    self
  end

  def each(*)
    collection.each do |object|
      yield(object)
    end
  end

  private

  def collection
    @collection ||= []
  end
end
