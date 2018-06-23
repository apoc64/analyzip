require 'rails_helper'

RSpec.describe Zip, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:n1)}
  end

  describe 'relationships' do
    it {should belong_to(:state)}
  end

  describe 'instance methods' do
    it 'should show percent single' do
      # Factory Bot???
      state = State.create(abbreviation: 'CO')
      zip = Zip.create(id: 80202, n1: 5000, mars1: 2000, mars2: 2500, mars4: 1000, prep: 750, numdep: 3000, elderly: 750, a00100: 4000000, state: state)
      # binding.pry
      expect(zip.percent_single).to eq(((zip.mars1.to_f / zip.n1.to_f) * 100).to_i)
    end
  end
end
