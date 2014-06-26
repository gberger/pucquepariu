require 'spec_helper'

describe String do
  describe '#downcased?' do
    it 'is true when downcased' do
      str = 'Abc'
      str.downcase!
      expect(str.downcased?).to be_true
    end

    it 'is false when upcased' do
      str = 'Abc'
      str.upcase!
      expect(str.downcased?).to be_false
    end
  end

  describe '#upcased?' do
    it 'is true when downcased' do
      str = 'Abc'
      str.upcase!
      expect(str.upcased?).to be_true
    end

    it 'is false when downcased' do
      str = 'Abc'
      str.downcase!
      expect(str.upcased?).to be_false
    end
  end
end
