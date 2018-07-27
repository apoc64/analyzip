require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}

    # if password_digest
      # it {should have_secure_password}
    # end
  end

  # describe 'relationships' do
  #   it {should have_many(:zips) through...}
  #   it {should have_many(:counties)}
  # end
end
