require 'spec_helper'

describe Course do
  describe 'relations' do
    it { should have_many(:exams).dependent(:destroy) }
    it { should have_many(:study_materials).dependent(:destroy) }
    it { should have_many(:course_ads).dependent(:delete) }
    it { should have_many(:chat_messages).dependent(:delete) }
    it { should have_and_belong_to_many(:majors) }
    it { should belong_to(:teacher).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:credits) }
    it { should validate_presence_of(:abbreviation) }
    it { should validate_uniqueness_of(:abbreviation) }
    it { should     allow_value('ABC1234' ).for(:abbreviation) }
    it { should_not allow_value('ABC12345').for(:abbreviation) }
    it { should_not allow_value('ABC123'  ).for(:abbreviation) }
    it { should_not allow_value('ABCD1234').for(:abbreviation) }
    it { should_not allow_value('AB1234'  ).for(:abbreviation) }
  end

  describe 'scopes' do
    it "orders by abbreviation by default" do
      inf = create(:course, abbreviation: 'INF1005')
      mat = create(:course, abbreviation: 'MAT1154')
      fis = create(:course, abbreviation: 'FIS1051')

      Course.all.should eq [fis, inf, mat]
    end
  end

  describe 'before_save' do
    it "upcases the abbreviation before saving" do
      @course = build(:course)
      @course.abbreviation.downcase!
      @course.save
      @course.abbreviation.should be_upcased
    end
  end

  describe :department_abbreviation do
    it "is part of the course's abbreviation" do
      @course = build(:course)
      @course.department_abbreviation.should eq(@course.abbreviation[0, 3])
    end
  end

  describe :name_with_abbreviation do
    it "joins the name and the abbreviation" do
      @course = build(:course)
      @course.name_with_abbreviation.should eq([@course.abbreviation, @course.name].join(' - '))
    end
  end
end
