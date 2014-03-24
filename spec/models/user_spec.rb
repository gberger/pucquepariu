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

  describe 'scopes' do
    before(:each) do
      @users = [create(:user), create(:user)]
      @teachers = [create(:teacher), create(:teacher)]
      @admins = [create(:admin), create(:admin)]
    end

    it '::admins' do
      User.admins.should match_array(@admins)
    end

    it '::teachers' do
      User.teachers.should match_array(@teachers)
    end

    it '::editors' do
      User.editors.should match_array(@teachers + @admins)
    end
  end

  describe :role? do
    it "should check if the user's role is at or above" do
      @user = build(:user)
      @teacher = build(:teacher)
      @admin = build(:admin)

      @user.role?(:basic).should be_true
      @user.role?(:teacher).should be_false
      @user.role?(:admin).should be_false

      @teacher.role?(:basic).should be_true
      @teacher.role?(:teacher).should be_true
      @teacher.role?(:admin).should be_false

      @admin.role?(:basic).should be_true
      @admin.role?(:teacher).should be_true
      @admin.role?(:admin).should be_true
    end
  end

  describe :role_above? do
    it "should check if the user's role is at or above" do
      @user = build(:user)
      @teacher = build(:teacher)
      @admin = build(:admin)

      @user.role_above?(:basic).should be_false
      @user.role_above?(:teacher).should be_false
      @user.role_above?(:admin).should be_false

      @teacher.role_above?(:basic).should be_true
      @teacher.role_above?(:teacher).should be_false
      @teacher.role_above?(:admin).should be_false

      @admin.role_above?(:basic).should be_true
      @admin.role_above?(:teacher).should be_true
      @admin.role_above?(:admin).should be_false
    end
  end
end
