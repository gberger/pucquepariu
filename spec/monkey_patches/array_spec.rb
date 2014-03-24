require 'spec_helper'

describe Array do
  describe '#drop' do
    it 'drops from the end with negative numbers' do
      arr = [11, 22, 33, 44].drop(-2)
      expect(arr).to eq [11, 22]
    end
  end
end
