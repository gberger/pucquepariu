class CoursesController < ApplicationController
  # sets @course and calls authorize!
  load_and_authorize_resource

  # GET /courses
  def index
    @courses = Course.all
  end

  # GET /courses/1
  def show
    unless params[:id].upcased?
      return redirect_to course_path(params[:id].upcase), status: :moved_permanently
    end

    return if @course.exams.empty?

    max_year = @course.exams.max_by(&:year_semester).year
    min_year = @course.exams.min_by(&:year_semester).year
    years = max_year.downto(min_year)
    semesters = years.to_a.product([2, 1])

    # TODO spaghetti
    @semesters_exams = semesters.reduce({}) do |h, semester|
      exams = @course.exams.select do |e|
      e[:year] == semester[0] && e[:semester] == semester[1]
      end
      a = {}
      (1..4).each do |num|
       a[num] = exams.find {|e| e[:number] == num }
      end
      h[semester.join(' - ')] = a
      h
    end
  end

  # GET /courses/new
  def new
  end

  # GET /courses/1/edit
  def edit
    unless params[:id].upcased?
      redirect_to edit_course_path(params[:id].upcase), status: :moved_permanently
    end
  end

  # POST /courses
  def create
    if @course.save
      redirect_to @course, notice: 'Course was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    redirect_to courses_url
  end

private
  # Never trust parameters from the scary internet, only allow the white list through.
  def course_params
    params.require(:course).permit(:abbreviation, :name, :credits, :study_plan, :teacher_id, :major_ids => [])
  end
end
