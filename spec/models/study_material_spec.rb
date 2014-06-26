require 'spec_helper'

describe StudyMaterial do
  describe 'relations' do
    it { should belong_to(:course) }
    it { should belong_to(:exam) }
  end

  describe 'validations' do
    it { should validate_presence_of(:course) }
    it { should_not validate_presence_of(:exam) }
  end
end
