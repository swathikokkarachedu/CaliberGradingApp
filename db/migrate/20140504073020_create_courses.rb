class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :prof_name
      t.integer :no_of_students

      t.timestamps
    end
  end
end
