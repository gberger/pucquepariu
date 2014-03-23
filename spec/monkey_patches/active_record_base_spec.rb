require 'spec_helper'

describe ActiveRecord::Base do
  describe '#pick' do
    it 'creates a hash from the given methods' do
      course = build(:course)
      hash = course.pick(:name, :abbreviation, :credits)

      expect(hash.keys).to match_array([:name, :abbreviation, :credits])

      hash.each_pair do |k, v|
        expect(v).to eq course.send(k)
      end
    end
  end
end