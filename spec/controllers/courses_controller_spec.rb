require 'spec_helper'

describe CoursesController do

  describe 'GET #index' do
    before { get :index }

    it { should respond_with(200) }
    it { should render_template('index') }
  end

end
