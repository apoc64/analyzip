require 'rails_helper'

RSpec.describe County, type: :model do

  describe 'relationships' do
    it {should belong_to(:state)}
  end
end
