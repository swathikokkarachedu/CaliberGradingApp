class StudentsController < ApplicationController
  # GET /students
  # GET /students.json
  require 'csv'
  
  def index
    @students = Student.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @students }
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @student = Student.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @student }
    end
  end

  # GET /students/new
  # GET /students/new.json
  def new
    @student = Student.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(params[:student])

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render json: @student, status: :created, location: @student }
      else
        format.html { render action: "new" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.json
  def update
    @student = Student.find(params[:id])

    respond_to do |format|
      if @student.update_attributes(params[:student])
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student = Student.find(params[:id])
    @student.destroy
   flash[:notice] = "Student has been deleted successfully"
    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end
  
  def export_student
    @student = Student.all
	student_csv = CSV.generate do |csv|
    csv << ["First Name","Last Name","Email", "Course Name"]
    @student.each do |student|
      csv << [student.fname,student.lname, student.email,student.cname]     
	end   
   end    
	send_data(student_csv, :type => 'text/csv', :filename => 'all_students.csv')
 end
 
 def import
   Student.import(params[:file])
   flash[:notice] = "Students has been imported successfully"
   redirect_to students_url
 end
 
 def update_grade
  @stu_gr = StudentGrade.where("student_id = ? and lab_id = ?",params[:id],params[:lab_id]).first
  if @stu_gr.present?
   #@stu_gr.grade= params[:grd]
   @stu_gr.update_attribute(:grade, params[:grd])       
  else
   StudentGrade.create(:student_id=>params[:id],:lab_id=>params[:lab_id],:grade=>params[:grd])
  end
  render :text => "success"
 end


def update_comments
  @stu_gr = StudentGrade.where("student_id = ? and lab_id = ?",params[:id],params[:lab_id]).first
  if @stu_gr.present?
   @stu_gr.update_attribute(:comment, params[:comments])       
  else
   StudentGrade.create(:student_id=>params[:id],:lab_id=>params[:lab_id],:grade=>params[:grd])
  end
  render :text => "success"
end

end
