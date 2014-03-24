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
    it { should ensure_inclusion_of(:year).in_range(1990..(Time.new.year)) }
    it { should ensure_inclusion_of(:semester).in_range(1..2) }
    it { should ensure_inclusion_of(:number).in_range(1..4) }
  end
end
