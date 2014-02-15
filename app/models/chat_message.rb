class ChatMessage < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  validates :text, length: {minimum: 1, maximum: 512}
  scope :recent, order("created_at DESC").limit(20)

  def as_json(options)
    {course: course.abbreviation, name: user.name, msg: text}
  end
end
