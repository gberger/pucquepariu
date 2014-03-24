require 'spec_helper'

describe CourseAd do
  describe 'relations' do
    it { should belong_to(:course) }
  end

  describe 'validations' do
    it { should validate_presence_of(:course) }
    it { should validate_presence_of(:image) }
    it { should validate_presence_of(:link) }
  end
end
