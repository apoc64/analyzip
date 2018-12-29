class ZipDecorator < Decorator
  def path
    url_helpers.zip_path(self)
  end

  def name
    code
  end
end
