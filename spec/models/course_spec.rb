require 'spec_helper'

describe Course do
  it "upcases the abbreviation" do
    course = build(:course)
    course.abbreviation.downcase!
    course.save
    course.abbreviation.should eq (course.abbreviation.upcase)
  end

  it "can get the department abbreviation" do
    course = build(:course)
    course.department_abbreviation.should_not be_nil
  end
end
