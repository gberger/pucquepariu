class ChatMessage < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  validates :text, length: {minimum: 1, maximum: 512}

  def as_json(options)
    {course: course.abbreviation, name: user.name, msg: text, timestamp: created_at.ms, id: id}
  end

  def timestamp
    created_at.ms
  end
end
