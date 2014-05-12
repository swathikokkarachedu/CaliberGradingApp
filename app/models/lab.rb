class Lab < ActiveRecord::Base
  attr_accessible :course_id, :due_date, :name, :total_marks
  
  belongs_to :course
end
