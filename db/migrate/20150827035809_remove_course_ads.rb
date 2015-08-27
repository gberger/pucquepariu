class RemoveCourseAds < ActiveRecord::Migration
  def change
    drop_table :course_ads
  end
end
