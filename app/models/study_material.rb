class StudyMaterial < ActiveRecord::Base
  belongs_to :course
  belongs_to :exam

  validates_presence_of :course, :content

  mount_uploader :content, ContentUploader
end
