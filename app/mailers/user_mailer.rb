class UserMailer < ActionMailer::Base
  default from: "authenticate@rebook.com"
  
  def welcome_email(user, host)
    @user = user
    @url = host + '/login?token='"#{@user.token}"

    mail(to: @user.email, subject: 'ReBook: Validate Email')
  end

  def reset_email(user, host)
    @user = user
    @user.generate_token
    @user.save(:validate => false)
    
    @url = host + '/reset?token='"#{@user.token}"
      mail(to: @user.email, subject: 'ReBook: Reset Password')
  end
  
  def trade_destroyed(user,trade)
	@user = user
	@trade = trade
	mail(to: @user.email, subject: 'ReBook: A trade has been cancelled')
  end
  
  def trade_email(trade, host)
    @trade = trade
    @url = host + '/trade_details/'"#{@trade.id}"
      @trade.trade_lines[1..-1].each do |x|
        email_trade_to_users(x.inventory_own.user.email).deliver
      end
  end
  
  def email_trade_to_users(user_email)
    mail(to: user_email, subject: 'ReBook: Someone Wants to Trade With You!')
  end
end
