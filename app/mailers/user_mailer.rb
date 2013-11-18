class UserMailer < ActionMailer::Base
  default from: "authenticate@rebook.com"
  
  def welcome_email(user)
    @user = user
    @url = Rebook::Application::REBOOK_DOMAIN + '/login?user_id='"#{@user.passhash}"

    mail(to: @user.email, subject: 'ReBook: Validate Email')
  end

  def reset_email(user)
    @user = user;
    @url = Rebook::Application::REBOOK_DOMAIN + '/login_reset?user_id='"#{@user.passhash}"

    mail(to: @user.email, subject: 'ReBook: Reset Password')
  end
end
