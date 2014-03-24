require 'spec_helper'

describe CoursesController do

  context 'when logged out' do
    before { @course = create(:course) }

    describe 'GET #index' do
      before { get :index }

      it { should respond_with(200) }
      it { should render_template('index') }
    end

    describe 'GET #new' do
      before { get :new }

      it { should respond_with(403) }
    end

    describe 'POST #create' do
      before { post :create }

      it { should respond_with(403) }
    end

    describe 'GET #show' do
      before { get :show, id: @course.abbreviation }

      it { should respond_with(200) }
      it { should render_template('show') }
      it { assigns[:course].should == @course }
    end

    describe 'GET #edit' do
      before { get :edit, id: @course.abbreviation }

      it { should respond_with(403) }
    end

    describe 'PUT #update' do
      before { put :update, id: @course.abbreviation }

      it { should respond_with(403) }
    end

    describe 'DELETE #destroy' do
      before { delete :destroy, id: @course.abbreviation }

      it { should respond_with(403) }
    end
  end

  context 'when logged in as a basic user' do
    before { session[:user_id] = create(:user).id }
    before { @course = create(:course) }

    describe 'GET #index' do
      before { get :index }

      it { should respond_with(200) }
      it { should render_template('index') }
    end

    describe 'GET #new' do
      before { get :new }

      it { should respond_with(403) }
    end

    describe 'POST #create' do
      before { post :create }

      it { should respond_with(403) }
    end

    describe 'GET #show' do
      before { get :show, id: @course.abbreviation }

      it { should respond_with(200) }
      it { should render_template('show') }
      it { assigns[:course].should == @course }
    end

    describe 'GET #edit' do
      before { get :edit, id: @course.abbreviation }

      it { should respond_with(403) }
    end

    describe 'PUT #update' do
      before { put :update, id: @course.abbreviation }

      it { should respond_with(403) }
    end

    describe 'DELETE #destroy' do
      before { delete :destroy, id: @course.abbreviation }

      it { should respond_with(403) }
    end
  end

  context 'when logged in as a teacher' do
    pending
  end

  context 'when logged in as an admin' do
    pending
  end

end
