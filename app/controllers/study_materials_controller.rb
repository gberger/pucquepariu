class StudyMaterialsController < ApplicationController
  authorize_resource

  # GET /course/INF1005/study_materials
  def show
    @course = Course.find_by_abbreviation(params[:course_abbreviation])
    authorize! :manage, @course
    @study_materials = StudyMaterial.where(course: @course)
  end

  # POST /study_materials
  def create
    @study_material = StudyMaterial.new(study_material_params)
    @study_material.parse_filename(study_material_params[:content].original_filename)
    authorize! :manage, @study_material.course
    @study_material.save
  end

  # DELETE /study_materials/1
  def destroy
    @study_material = StudyMaterial.find(params[:id])
    @course = @study_material.course
    authorize! :manage, @course
    @study_material.destroy
    redirect_to course_study_materials_url(@course), notice: 'Study material was successfully destroyed.'
  end

private
  # Only allow a trusted parameter "white list" through.
  def study_material_params
    params.require(:study_material).permit(:course, :course_id, :exam, :exam_id, :content, :title)
  end
end
