class StudyMaterial < ActiveRecord::Base
  belongs_to :course
  belongs_to :exam

  validates_presence_of :course, :content

  mount_uploader :content, ContentUploader

  def parse_filename(filename)
    filename_without_extension = filename.split('.').drop(-1).join('.')
    parts = filename_without_extension.split('-')

    self.course = Course.find_by_abbreviation(parts[0])

    if m = /([A-Z]{3}\d{4})\-(\d{4})\-(\d)\-.(\d)\-([^\-]*)\-([^\-]*)/.match(filename_without_extension)
      year = m[2]
      semester = m[3]
      number = m[4]
      exam = Exam.where(year: year, semester: semester, number: number, course_id: self.course.id).first_or_create
      self.exam = exam

      if m[5].empty?
        self.title = m[6]
      else
        self.title = m[5] + ' - ' + m[6]
      end
    else
      self.title = parts.drop(1).join('-')
    end
  end
end
