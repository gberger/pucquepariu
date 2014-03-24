require 'spec_helper'

describe Time do
  describe '#semester' do
    it 'is 1 when between January and June' do
      expect(Time.new(2014, 01, 01).semester).to be 1
      expect(Time.new(2014, 06, 30).semester).to be 1
    end

    it 'is 2 when between July and December' do
      expect(Time.new(2014, 07, 01).semester).to be 2
      expect(Time.new(2014, 12, 31).semester).to be 2
    end
  end

  describe '#ms' do
    it 'is the Time in milliseconds' do
      t = Time.now
      expect(t.ms).to be_within(1000).of(t.to_i*1000)
    end
  end

  describe '#to_date' do
    it 'parses the Time as a Date' do
      t = Time.now
      expect(t.to_date).to eq Date.parse(t.to_s)
    end
  end
end
