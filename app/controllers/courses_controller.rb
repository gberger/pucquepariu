class CoursesController < ApplicationController
  # GET /courses
  def index
    @courses = Course.all
  end

  # GET /courses/1
  def show
    @course = Course.find_by_abbreviation(params[:id])
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find_by_abbreviation(params[:id])
  end

  # POST /courses
  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to @course, notice: 'course was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /courses/1
  def update
    @course = Course.find_by_abbreviation(params[:id])

    if @course.update(course_params)
      redirect_to @course, notice: 'course was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /courses/1
  def destroy
    @course = Course.find_by_abbreviation(params[:id])
    @course.destroy
    redirect_to courses_url
  end

private
  # Never trust parameters from the scary internet, only allow the white list through.
  def course_params
    params.require(:course).permit(:abbreviation, :name, :credits)
  end
end
