class Course < ActiveRecord::Base
  validates_presence_of :abbreviation, :name, :credits
  validates_uniqueness_of :abbreviation, case_sensitive: false

  def to_param
    abbreviation
  end

  def department_abbreviation
    self.abbreviation[0, 3]
  end

  before_validation :upcase_abbreviation
  def upcase_abbreviation
    self.abbreviation.upcase! if self.abbreviation
  end
end
