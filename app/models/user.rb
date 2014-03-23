class User < ActiveRecord::Base
  has_many :chat_messages

  ROLES = %w[basic teacher admin]
  validate :role, inclusion: {in: ROLES}

  default_scope { order('id ASC') }
  scope :admin, -> { where(role: 'admin') }
  scope :teacher, -> {where('role=? OR role=?', 'admin', 'teacher')}

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.nickname = auth.info.nickname
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
