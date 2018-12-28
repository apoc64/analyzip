require 'rails_helper'

RSpec.describe Zip, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:n1)}
  end

  describe 'relationships' do
    it {should belong_to(:state)}
  end

  describe 'instance methods' do
    it 'should show percent filing singly' do
      state = State.create(abbreviation: 'CO')
      zip = Zip.create(id: 80202, n1: 5000, mars1: 2000, mars2: 2500, mars4: 1000, prep: 750, numdep: 3000, elderly: 750, a00100: 4000000, state: state)
      expect(zip.single).to eq(zip.mars1.to_f / zip.n1.to_f)
    end

    it 'should show percent filing jointly' do
      zip = create(:zip)
      expect(zip.joint).to eq(zip.mars2.to_f / zip.n1.to_f)
    end

    describe 'code is 5 character number string' do
      it 'returns a string' do
        state = State.create(abbreviation: 'CO')
        zip = Zip.create(id: 80202, n1: 5000, mars1: 2000, mars2: 2500, mars4: 1000, prep: 750, numdep: 3000, elderly: 750, a00100: 4000000, state: state)
        expect(zip.code).to eq('80202')
      end

      it 'Adds a zero for 4 digit ids' do
        state = State.create(abbreviation: 'CO')
        zip = Zip.create(id: 8202, n1: 5000, mars1: 2000, mars2: 2500, mars4: 1000, prep: 750, numdep: 3000, elderly: 750, a00100: 4000000, state: state)
        expect(zip.code).to eq('08202')
      end
    end
  end
end
