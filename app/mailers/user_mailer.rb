class UserMailer < ActionMailer::Base
  default from: "authenticate@rebook.com"
  
  def welcome_email(user)
    @user = user
    #@url  = 'localhost:3000/login'
	@url  = 'rebook.herokuapp.com/login'
    mail(to: @user.email, subject: 'ReBook: Validate Email')
  end
end
