class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_filter :validate_user

  private

  def admin?
    user = current_user
    (not user.nil?) and user.id == 10
  end

  def current_user
    user_id = session[:user_id]

    unless user_id.nil? 
      user_id = user_id.to_i
    end

    User.find(user_id.to_i)
  end

  def validate_user() 
    loginPage = ["/users"]
    unrestricted = ["/users/new",
					"/forgot"]
    if session[:user_id] != nil
      # continue to current_user url
	  if session[:user_id] != 10 && loginPage.include?(url_for :only_path=>true)
		redirect_to("http://localhost:3000/")
	  end
    else
		if not unrestricted.include?(url_for :only_path=>true)
			flash[:error] = "Please access one of your own pages"
			redirect_to("http://localhost:3000/")
		end
	end
  end
end






