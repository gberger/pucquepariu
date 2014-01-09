class ExamsController < ApplicationController
  authorize_resource

  # GET /exams
  def index
    @exams = Exam.all
  end

  # GET /exams/new
  def new
    @exam = Exam.new
  end

  # GET /exams/1/edit
  def edit
    @exam = Exam.find(params[:id])
  end

  # POST /exams
  def create
    @exam = Exam.new(exam_params)

    if @exam.save
      redirect_to action: :index, notice: 'Exam was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /exams/1
  def update
    @exam = Exam.find(params[:id])
    if @exam.update(exam_params)
      redirect_to action: :index, notice: 'Exam was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /exams/1
  def destroy
    @exam = Exam.find(params[:id])
    @exam.destroy
    redirect_to exams_url, notice: 'Exam was successfully destroyed.'
  end

private
  # Only allow a trusted parameter "white list" through.
  def exam_params
    params.require(:exam).permit(:year, :semester, :number, :course, :course_id)
  end
end
