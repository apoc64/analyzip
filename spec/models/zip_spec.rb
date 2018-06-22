require 'rails_helper'

RSpec.describe Zip, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:n1)}
  end

  describe 'relationships' do
    it {should belong_to(:state)}
  end
end
