class Exam < ActiveRecord::Base
  belongs_to :course
  has_many :study_materials, dependent: :destroy

  validates_presence_of :year, :semester, :number, :course
  validates_inclusion_of :year, in: 1990..(Time.new.year)
  validates_inclusion_of :semester, in: 1..2
  validates_inclusion_of :number, in: 1..4

  # Unique on all columns at the same time -- tests are failing
  validates_uniqueness_of :year, scope: [:semester, :number, :course]

  default_scope { order("number ASC, year DESC, semester DESC") }

  def p
    'P' + self.number.to_s
  end

  def summary
    "#{self.course.abbreviation}-#{self.year}-#{self.semester}-#{self.p}"
  end

  def year_semester
    "#{self.year}-#{self.semester}"
  end
end
