class State < ApplicationRecord
  validates_presence_of :abbreviation
  has_many :zips
end
