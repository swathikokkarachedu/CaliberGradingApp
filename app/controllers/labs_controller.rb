class LabsController < ApplicationController
    require 'csv'

  # GET /labs
  # GET /labs.json
  def index
    @labs = Lab.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @labs }
    end
  end

  # GET /labs/1
  # GET /labs/1.json
  def show
    @lab = Lab.find(params[:id])
    @lab_student = Student.where("cname = ?",@lab.course.name)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lab }
    end
  end
  
  def student_history
   if params[:id].present?
	@l = StudentGrade.where("student_id = ?",params[:id])
   end
   render :partial => "student_history", :object => @l
  end
  
   def email_grades
   
     @sg = StudentGrade.where("lab_id=?", params[:id])
	 @l = Lab.find(params[:id])
      @sg.each do |student|
	   @stu = Student.find student.student_id
	     StudentNotify.notification(@stu.email,@stu.fname,student.grade, student.comment,@l.name).deliver
	end	
	redirect_to request.referrer
	flash[:notice] = "Email sent successfully"
  end
   
  def export_student
    @g = StudentGrade.where("lab_id =?", params[:id])
	@lab_name = Lab.find params[:id]
	lname = @lab_name.name
	student_csv = CSV.generate do |csv|
    csv << ["Student FName", "Student LName", "Grade", "Comment"]
	puts "####################################"
	p @g
    @g.each do |student|
	  @stu = Student.find student.student_id
      csv << [@stu.fname,@stu.lname,student.grade, student.comment]  
     end   
   end  
   send_data(student_csv, :type=> 'text/csv', :filename => 'Student_Grades.csv')
  end
  
  
  
  
  # GET /labs/new
  # GET /labs/new.json
  def new
    @lab = Lab.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lab }
    end
  end

  # GET /labs/1/edit
  def edit
    @lab = Lab.find(params[:id])
  end

  # POST /labs
  # POST /labs.json
  def create
    @lab = Lab.new(params[:lab])

    respond_to do |format|
      if @lab.save
        format.html { redirect_to @lab, notice: 'Lab was successfully created.' }
        format.json { render json: @lab, status: :created, location: @lab }
      else
        format.html { render action: "new" }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /labs/1
  # PUT /labs/1.json
  def update
    @lab = Lab.find(params[:id])

    respond_to do |format|
      if @lab.update_attributes(params[:lab])
        format.html { redirect_to @lab, notice: 'Lab was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end
  
   
   

  # DELETE /labs/1
  # DELETE /labs/1.json
  def destroy
    @lab = Lab.find(params[:id])
    @lab.destroy
    flash[:notice] = "Lab has been deleted successfully"
    respond_to do |format|
      format.html { redirect_to labs_url }
      format.json { head :no_content }
    end
  end
end
