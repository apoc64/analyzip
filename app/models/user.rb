class User < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :email, presence: true, uniqueness: true

  has_many :user_zips, dependent: :nullify
  has_many :zips, through: :user_zips

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize.tap do |user|
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.token = auth.credentials.token
      user.provider = auth.provider

      user.save!
    end
  end
end
