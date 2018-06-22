class Zip < ApplicationRecord
  validates_presence_of :n1

  belongs_to :state
end
