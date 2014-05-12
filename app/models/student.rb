class Student < ActiveRecord::Base
  attr_accessible :cname, :email, :fname, :lname, :grade, :comment, :lab_id
  
  def self.import(file)
  CSV.foreach(file.path, headers: true) do |row|
    Student.create! row.to_hash
  end
end

end
