require 'spec_helper'

describe User do
  describe 'validations' do
    it { should validate_presence_of(:role) }
    it { should ensure_inclusion_of(:role).in_array(%w[basic teacher admin]) }
  end

  describe 'scopes' do
    before(:each) do
      @users = create_list(:user, 2)
      @teachers = create_list(:teacher, 2)
      @admins = create_list(:admin, 2)
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
    context 'when basic user' do
      subject { build(:user) }
      its(:role?, :basic)   { should be_true  }
      its(:role?, :teacher) { should be_false }
      its(:role?, :admin)   { should be_false }
    end

    context 'when teacher user' do
      subject { build(:teacher) }
      its(:role?, :basic)   { should be_true  }
      its(:role?, :teacher) { should be_true  }
      its(:role?, :admin)   { should be_false }
    end

    context 'when admin user' do
      subject { build(:admin) }
      its(:role?, :basic)   { should be_true  }
      its(:role?, :teacher) { should be_true  }
      its(:role?, :admin)   { should be_true  }
    end
  end

  describe :role_above? do
    context 'when basic user' do
      subject { build(:user) }
      its(:role_above?, :basic)   { should be_false }
      its(:role_above?, :teacher) { should be_false }
      its(:role_above?, :admin)   { should be_false }
    end

    context 'when teacher user' do
      subject { build(:teacher) }
      its(:role_above?, :basic)   { should be_true  }
      its(:role_above?, :teacher) { should be_false }
      its(:role_above?, :admin)   { should be_false }
    end

    context 'when admin user' do
      subject { build(:admin) }
      its(:role_above?, :basic)   { should be_true  }
      its(:role_above?, :teacher) { should be_true  }
      its(:role_above?, :admin)   { should be_false }
    end
  end
end
