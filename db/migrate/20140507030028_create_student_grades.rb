class CreateStudentGrades < ActiveRecord::Migration
  def change
    create_table :student_grades do |t|
      t.integer :student_id
	  t.integer :lab_id
	  t.string :grade
	  t.text :comment
      t.timestamps
    end
  end
end
