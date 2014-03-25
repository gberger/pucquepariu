require 'spec_helper'

describe CoursesController do

  describe 'GET #index' do
    before { get :index }

    it { should respond_with(200) }
    it { should render_template('index') }
  end

  describe 'GET #new' do
    with_context 'when logged out' do
      before { get :new }
      it { should respond_with(403) }
    end

    with_context 'when logged in as a basic user' do
      before { get :new }
      it { should respond_with(403) }
    end

    with_context 'when logged in as a teacher' do
      before { get :new }
      it { should respond_with(403) }
    end

    with_context 'when logged in as an admin' do
      before { get :new }
      it { should respond_with(200) }
      it { should render_template('new') }
    end
  end

  describe 'POST #create' do
    with_context 'when logged out' do
      before { post :create, course: attributes_for(:course) }
      it { should respond_with(403) }
    end

    with_context 'when logged in as a basic user' do
      before { post :create, course: attributes_for(:course) }
      it { should respond_with(403) }
    end

    with_context 'when logged in as a teacher' do
      before { post :create, course: attributes_for(:course) }
      it { should respond_with(403) }
    end

    with_context 'when logged in as an admin' do
      context 'with invalid attributes' do
        before { post :create, course: attributes_for(:invalid_course) }
        it { should respond_with(200) }
        it { should render_template('new') }
      end

      context 'with valid attributes' do
        before { post :create, course: attributes_for(:course) }
        it { should respond_with(302) }
        it { should set_the_flash[:notice] }
      end
    end
  end

  describe 'GET #show' do
    before { @course = create(:course) }
    before { get :show, id: @course.abbreviation }

    it { should respond_with(200) }
    it { should render_template('show') }
    it "locates the course" do
      assigns[:course].should == @course
    end
  end

  describe 'GET #edit' do
    with_context 'when logged out' do
      before { get :edit, id: create(:course) }
      it { should respond_with(403) }
    end

    with_context 'when logged in as a basic user' do
      before { get :edit, id: create(:course) }
      it { should respond_with(403) }
    end

    with_context 'when logged in as a teacher' do
      with_context "who doesn't teach the course" do
        before { get :edit, id: @course.abbreviation }
        it { should respond_with(403) }
      end

      with_context 'who teaches the course' do
        before { get :edit, id: @course.abbreviation }
        it { should respond_with(200) }
        it { should render_template('edit') }
        it "locates the course" do
          assigns[:course].should == @course
        end
      end
    end

    with_context 'when logged in as an admin' do
      before { @course = create(:course) }
      before { session[:user_id] = create(:admin) }
      before { get :edit, id: @course.abbreviation }
      it { should respond_with(200) }
      it { should render_template('edit') }
      it "locates the course" do
        assigns[:course].should == @course
      end
    end
  end

  describe 'PUT #update' do
    context 'when logged out' do
      before { put :update, id: create(:course).abbreviation, course: attributes_for(:course) }
      it { should respond_with(403) }
    end
  
    with_context 'when logged in as a basic user' do
      before { put :update, id: create(:course).abbreviation, course: attributes_for(:course) }
      it { should respond_with(403) }
    end
  
    with_context 'when logged in as a teacher' do
      with_context "who doesn't teach the course" do
        before { put :update, id: @course.abbreviation, course: attributes_for(:course) }
        it { should respond_with(403) }
      end

      with_context 'who teaches the course' do
        context "with invalid attributes" do
          before { put :update, id: @course.abbreviation, course: attributes_for(:invalid_course) }
          it { should respond_with(200) }
          it { should render_template('edit') }
        end

        context "with valid attributes" do
          before { put :update, id: @course.abbreviation, course: attributes_for(:course) }
          it { should respond_with(302) }
          it "locates the course" do
            assigns[:course].should == @course
          end
        end
      end
    end

    with_context 'when logged in as an admin' do
      context "with invalid attributes" do
        before { put :update, id: create(:course).abbreviation, course: attributes_for(:invalid_course) }
        it { should respond_with(200) }
        it { should render_template('edit') }
      end

      context "with valid attributes" do
        before { put :update, id: create(:course).abbreviation, course: attributes_for(:course) }
        it "locates the course" do
          assigns[:course].should == Course.last
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    with_context 'when logged out' do
      before { delete :destroy, id: create(:course).abbreviation }
      it { should respond_with(403) }
    end

    with_context "when logged in as a basic user" do
      before { delete :destroy, id: create(:course).abbreviation }
      it { should respond_with(403) }
    end

    with_context "when logged in as a teacher" do
      with_context "who doesn't teach the course" do
        before { delete :destroy, id: @course.abbreviation }
        it { should respond_with(403) }
      end
      with_context "who teaches the course" do
        before { delete :destroy, id: @course.abbreviation }
        it { should respond_with(302) }
        it { should redirect_to(courses_url) }
      end
    end

    with_context "when logged in as an admin" do
      before { delete :destroy, id: create(:course).abbreviation }
      it { should respond_with(302) }
    end
  end
end
