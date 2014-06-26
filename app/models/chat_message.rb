class ChatMessage < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  validates :text, length: {minimum: 1, maximum: 512}
  validates_presence_of :user, :course, :text

  def timestamp
    created_at.ms
  end
end
