class UserMailer < ActionMailer::Base
  default from: "authenticate@rebook.com"
  
  def welcome_email(user)
    @user = user
    @url = Rebook::Application::REBOOK_DOMAIN + '/login?user_id='"#{@user.passhash}"

    mail(to: @user.email, subject: 'ReBook: Validate Email')
  end

  def reset_email(user)
    @user = user;
    @url = Rebook::Application::REBOOK_DOMAIN + '/reset?user_id='"#{@user.passhash}"

    mail(to: @user.email, subject: 'ReBook: Reset Password')
  end
  
  def trade_email(trade)
	@trade = trade;
	@url = Rebook::Application::REBOOK_DOMAIN + '/matches'
	@trade.trade_lines.drop(1).each do |x|
		mail(to: x.inventory_own.user.email, subject: 'ReBook: Someone Wants to Trade With You!')
	end
  end
end
