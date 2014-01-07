class Course < ActiveRecord::Base
  has_many :exams
  has_many :study_materials

  validates_presence_of :abbreviation, :name, :credits
  validates_uniqueness_of :abbreviation, case_sensitive: false

  extend FriendlyId
  friendly_id :abbreviation

  def department_abbreviation
    self.abbreviation[0, 3]
  end

  def name_with_abbreviation
    "#{self.abbreviation} - #{self.name}"
  end

  before_validation :upcase_abbreviation
  def upcase_abbreviation
    self.abbreviation.upcase! if self.abbreviation
  end
end
