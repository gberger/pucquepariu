require 'spec_helper'

describe Course do
  it "upcases the abbreviation" do
    course = build(:course)
    course.abbreviation.downcase!
    course.save
    course.abbreviation.should eq (course.abbreviation.upcase)
  end

  describe :department_abbreviation do
    it "is not nil" do
      course = build(:course)
      course.department_abbreviation.should_not be_nil
    end

    it "is part of the course's abbreviation" do
      course = build(:course)
      course.department_abbreviation.should eq (course.abbreviation[0, 3])
    end
  end
end
