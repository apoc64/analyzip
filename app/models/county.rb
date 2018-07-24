class County < ApplicationRecord
  belongs_to :state

  def name
    county
  end
end
