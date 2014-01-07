class Exam < ActiveRecord::Base
  belongs_to :course

  # Unique on all columns at the same time
  validates_uniqueness_of :course, scope: [:year, :semester, :number]
  validates_presence_of :year, :semester, :number, :course
end
