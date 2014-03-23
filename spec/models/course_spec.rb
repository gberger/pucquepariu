require 'spec_helper'

describe Course do
  before(:each) do
    @course = build(:course)
  end

  describe 'validations' do
    it "is invalid without a name" do
      expect(build(:course, name: nil)).not_to be_valid
    end

    it "is invalid without credits" do
      expect(build(:course, credits: nil)).not_to be_valid
    end

    it "is invalid without an abbreviation" do
      expect(build(:course, abbreviation: nil)).not_to be_valid
    end

    it "is invalid with duplicate abbreviations" do
      @course.save
      expect(build(:course, abbreviation: @course.abbreviation)).not_to be_valid
    end

    it "is invalid with different abbreviation format" do
      expect(build(:course, abbreviation: 'ABC12345')).not_to be_valid
      expect(build(:course, abbreviation: 'ABC123')).not_to be_valid
      expect(build(:course, abbreviation: 'ABCD1234')).not_to be_valid
      expect(build(:course, abbreviation: 'AB1234')).not_to be_valid
    end
  end

  describe 'scopes' do
    it "orders by abbreviation by default" do
      inf = create(:course, abbreviation: 'INF1005')
      mat = create(:course, abbreviation: 'MAT1154')
      fis = create(:course, abbreviation: 'FIS1051')

      expect(Course.all).to eq [fis, inf, mat]
    end
  end

  describe 'before_save' do
    it "upcases the abbreviation before saving" do
      @course.abbreviation.downcase!
      @course.save
      expect(@course.abbreviation).to be_upcased
    end
  end

  describe :department_abbreviation do
    it "is not nil" do
      expect(@course.department_abbreviation).not_to be_nil
    end

    it "is part of the course's abbreviation" do
      expect(@course.department_abbreviation).to eq(@course.abbreviation[0, 3])
    end
  end

  describe :name_with_abbreviation do
    it "is not nil" do
      expect(@course.name_with_abbreviation).not_to be_nil
    end

    it "joins the name and the abbreviation" do
      expect(@course.name_with_abbreviation).to eq("#{@course.abbreviation} - #{@course.name}")
    end
  end
end
