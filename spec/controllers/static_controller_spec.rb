require 'spec_helper'

describe StaticController do

  describe 'get #index' do
    before { get :index }

    it { should respond_with(200) }
    it { should render_template('index') }
  end

  describe 'get #ping' do
    before { get :ping }

    it { should respond_with(200) }
  end

end
  