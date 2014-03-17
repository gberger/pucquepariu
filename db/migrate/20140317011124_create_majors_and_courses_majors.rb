class CreateMajorsAndCoursesMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      t.string :name
    end

    create_table :courses_majors do |t|
      t.belongs_to :course
      t.belongs_to :major
    end
  end
end
