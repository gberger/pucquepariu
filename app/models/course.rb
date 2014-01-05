class Course < ActiveRecord::Base
  attr_accessor :abbreviation, :name, :credits

  validates_presence_of :abbreviation, :name, :credits
  validates_uniqueness_of :abbreviation, case_sensitive: false

  def department_abbreviation
    self.abbreviation[0, 3]
  end

  before_validation :upcase_abbreviation
  def upcase_abbreviation
    self.abbreviation.upcase!
  end

private

  def course_params
    params.require(:course).permit(:abbreviation, :name, :credits)
  end

end
