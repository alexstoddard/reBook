class LoginController < ApplicationController

  def logout 
    session[:user_id] = nil
    session[:user_name] = nil
      redirect_to root_path
  end

  def show
	if params[:user_id] != nil
		user = User.find_by_passhash(params[:user_id])
		if(not user.nil?)
			user.activated = true;
			user.save
			flash[:verified] = "You have successfully validated your account!"
		end
	end
	
  end

  def attempt

    username = params[:login_username]
    password = params[:login_passhash]
    
    user = User.authenticate(username, password)

    username = nil
    password = nil
    if user.nil?
	  flash[:notice] = "Password or username does not match any user"
      flash[:color] = "invalid"
      redirect_to login_path
    elsif !user.activated
	  flash[:notice] = "Please verify your email"
      flash[:color] = "invalid"
      redirect_to login_path
	else
	  session[:user_id] = user.id
      session[:user_name] = user.username
      redirect_to root_path
    end
  end

end
