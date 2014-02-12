class CreateCourseAds < ActiveRecord::Migration
  def change
    create_table :course_ads do |t|
      t.string :image
      t.string :link
      t.integer :course_id

      t.timestamps
    end
  end
end
