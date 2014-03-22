class StudyMaterialsController < ApplicationController
  authorize_resource

  # GET /course/INF1005/study_materials
  def index
    @course = Course.find_by_abbreviation(params[:course_id])
    authorize! :manage, @course

    @study_materials = StudyMaterial.where(course: @course)
    @study_material = @course.study_materials.build
  end

  # POST /course/INF1005/study_materials
  def create
    @course = Course.find_by_abbreviation(params[:course_id])
    authorize! :manage, @course

    @study_material = StudyMaterial.new_from_filename(study_material_params)
    @study_material.save
  end

  # DELETE /course/INF1005/study_materials/1
  def destroy
    @course = Course.find_by_abbreviation(params[:course_id])
    authorize! :manage, @course

    @study_material = @course.study_materials.find(params[:id])
    @study_material.destroy
    redirect_to course_study_materials_url(@course), notice: 'Study material was successfully destroyed.'
  end

private
  # Only allow a trusted parameter "white list" through.
  def study_material_params
    params.require(:study_material).permit(:course, :course_id, :exam, :exam_id, :content, :title)
  end
end
