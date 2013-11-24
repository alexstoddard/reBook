class LoginController < ApplicationController
  
  def logout 
    session[:user_id] = nil
    session[:user_name] = nil
      redirect_to root_path
  end

  def show
  @referer = session[:return_to]

	if params[:token] != nil
		user = User.find_by_token(params[:token])
		if(not user.nil?)
      user.token = nil
			user.activated = true;
      user.passhash_confirmation = user.passhash
			user.save
			flash[:verified] = "You have successfully validated your account!"
		end
	end
	
  end

  def attempt
    @referer = params[:referer]
    username = params[:login_username]
    password = params[:login_passhash]
    
    user = User.authenticate(username, password)

    username = nil
    password = nil
    if user.nil?
	  flash[:login_error] = "Password or username does not match any user"
      flash[:color] = "invalid"
      redirect_to login_path
    elsif !user.activated
	  flash[:login_error] = "Please verify your email"
      flash[:color] = "invalid"
      redirect_to login_path
	else
	  session[:user_id] = user.id
      session[:user_name] = user.username
      if @referer.nil?
        redirect_to root_path
      else
        session[:return_to] = nil
        redirect_to @referer
      end
    end
  end
end
