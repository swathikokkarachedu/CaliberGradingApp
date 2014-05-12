class StudentGrade < ActiveRecord::Base
  attr_accessible :student_id, :lab_id, :grade, :comment
end
