require 'spec_helper'

describe Exam do
  describe 'relations' do
    it { should have_many(:study_materials).dependent(:destroy) }
    it { should belong_to(:course) }
  end

  describe 'validations' do
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:semester) }
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:course) }
  end
end
