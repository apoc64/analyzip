class User < ApplicationRecord
  # has_secure_password
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :email, presence: true, uniqueness: true

  def self.from_omniauth(auth)
    # binding.pry
    where(email: auth.info.email).first_or_initialize.tap do |user|
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.token = auth.credentials.token
      user.provider = auth.provider

      user.save!
    end
  end
end
