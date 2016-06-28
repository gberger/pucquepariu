class User < ActiveRecord::Base
  has_many :chat_messages

  ROLES = %w[basic teacher admin]
  validates_inclusion_of :role, in: ROLES
  validates_presence_of :role

  default_scope { order('id ASC') }
  scope :admins, -> { where(role: 'admin') }
  scope :teachers, -> { where(role: 'teacher') }
  scope :editors, -> { where('role=? OR role=?', 'admin', 'teacher') }

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def role_above?(base_role)
    ROLES.index(base_role.to_s) < ROLES.index(role)
  end
end
