class UserZip < ApplicationRecord
  belongs_to :zip
  belongs_to :user

end
