class UserMailer < ActionMailer::Base
  default from: "authenticate@rebook.com"
  
  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/login?user_id='"#{@user.id}"
	#@url  = 'rebook.herokuapp.com/login'
    mail(to: @user.email, subject: 'ReBook: Validate Email')
  end
end
