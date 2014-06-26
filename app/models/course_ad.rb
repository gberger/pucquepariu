class CourseAd < ActiveRecord::Base
  belongs_to :course

  validates_presence_of :course, :image, :link

end
