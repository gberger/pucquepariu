class CreateStudyMaterials < ActiveRecord::Migration
  def change
    create_table :study_materials do |t|
      t.references :course, index: true
      t.references :exam, index: true
      t.string :content
      t.string :title

      t.timestamps
    end
  end
end
