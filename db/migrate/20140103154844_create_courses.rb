class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :abbreviation
      t.integer :credits

      t.timestamps
    end
    add_index :courses, :name
    add_index :courses, :abbreviation
  end
end
