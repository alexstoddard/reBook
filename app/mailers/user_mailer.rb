class UserMailer < ActionMailer::Base
  default from: "authenticate@rebook.com"
  
  def welcome_email(user)
    @user = user
    #@url  = 'http://localhost:3000/login?user_id='"#{@user.passhash}"
    @url  = 'rebook.herokuapp.com/login?user_id='"#{@user.passhash}"
    mail(to: @user.email, subject: 'ReBook: Validate Email')
  end

  def reset_email(user)
    @user = user
    #@url  = 'http://localhost:3000/login_reset?user_id='"#{@user.passhash}"
    @url  = 'rebook.herokuapp.com/login_reset?user_id='"#{@user.passhash}"
    mail(to: @user.email, subject: 'ReBook: Reset Password')
  end
end
