class AddStudyPlanToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :study_plan, :text, default: ''
  end
end
