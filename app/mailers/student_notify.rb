class StudentNotify < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_notify.notification.subject
  #
 
  def notification(user,fname,grade, comment,labname)
    @grade = grade
	@fname = fname
	@comment = comment
	@lab_name = labname
    mail(to: user, subject: 'Lab Grade')
  end
  
  
end
