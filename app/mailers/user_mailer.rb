class UserMailer < ActionMailer::Base
  default from: "authenticate@rebook.com"
  
  def welcome_email(user)
    @user = user
    if Rebook::Application::REBOOK_DOMAIN == "localhost:3000"
		@url  = 'http://localhost:3000/login?user_id='"#{@user.passhash}"
	else
		@url  = 'rebook.herokuapp.com/login?user_id='"#{@user.passhash}"
	end
    mail(to: @user.email, subject: 'ReBook: Validate Email')
  end

  def reset_email(user)
    @user = user
	if Rebook::Application::REBOOK_DOMAIN == "localhost:3000"
		@url  = 'http://localhost:3000/login_reset?user_id='"#{@user.passhash}"
	else
		@url  = 'rebook.herokuapp.com/login_reset?user_id='"#{@user.passhash}"
	end
    mail(to: @user.email, subject: 'ReBook: Reset Password')
  end
end
