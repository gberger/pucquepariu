class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.integer :year
      t.integer :semester
      t.integer :number
      t.references :course, index: true

      t.timestamps
    end
  end
end
