class StudyMaterialsController < ApplicationController
  authorize_resource

  # GET /study_materials
  def index
    @study_materials = StudyMaterial.all
  end

  # POST /study_materials
  def create
    @study_material = StudyMaterial.new(study_material_params)
    @study_material.parse_filename(study_material_params[:content].original_filename)
    @study_material.save
  end

  # DELETE /study_materials/1
  def destroy
    @study_material = StudyMaterial.find(params[:id])
    @study_material.destroy
    redirect_to study_materials_url, notice: 'Study material was successfully destroyed.'
  end

private
  # Only allow a trusted parameter "white list" through.
  def study_material_params
    params.require(:study_material).permit(:course, :course_id, :exam, :exam_id, :content, :title)
  end
end
