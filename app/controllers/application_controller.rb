class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :validate_user

  private

  def validate_user() 

    debugger

    if session[:user_id] != nil
      # continue to current_user url
	  if session[:user_id] != 10 && request.original_url == "http://localhost:3000/users"
		redirect_to("http://localhost:3000/")
	  end
    else
        flash[:error] = "Please access one of your own pages"
        redirect_to("http://localhost:3000/")
    end
  end
end






