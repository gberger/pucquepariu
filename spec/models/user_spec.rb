require 'spec_helper'

describe User do
  describe 'relations' do
    it { should have_many :chat_messages }
  end

  describe 'validations' do
    it { should_not validate_presence_of(:chat_messages) }
    it { should validate_presence_of(:role) }
    it { should ensure_inclusion_of(:role).in_array(%w[basic teacher admin]) }
  end
end
