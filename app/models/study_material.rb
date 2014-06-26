class StudyMaterial < ActiveRecord::Base
  belongs_to :course
  belongs_to :exam

  validates_presence_of :course, :content

  mount_uploader :content, ContentUploader

  scope :ordered, -> { joins(:course).order("courses.abbreviation") }
  scope :recent, -> { order("created_at desc").where(created_at: (Date.today-1.month)..Date.today) }

  def self.new_from_filename(params)
    sm = self.new(params)
    sm.send(:parse_filename, params[:content].original_filename)
    sm
  end

private

  def parse_filename(filename)
    filename_without_extension = filename.split('.').drop(-1).join('.')
    parts = filename_without_extension.split('-')

    self.course = Course.find(parts[0].upcase)

    if m = /^([A-Z]{3}\d{4})\-(\d{4})\-(\d)\-.(\d)\-(.*)/.match(filename_without_extension)
      year = m[2]
      semester = m[3]
      number = m[4]
      exam = Exam.where(year: year, semester: semester, number: number, course_id: self.course.id).first_or_create
      self.exam = exam

      self.title = m[5].split('-').select do |str|
        not str.empty?
      end.join(' - ').titleize
    else
      self.title = parts.drop(1).join('-').titleize
    end
  end
end
