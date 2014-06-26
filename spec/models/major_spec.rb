require 'spec_helper'

describe Major do
  describe 'relations' do
    it { should have_and_belong_to_many(:courses) }
  end
end
