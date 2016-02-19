class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def current_user
  	if session[:user_id]
  		if session[:user_type] == "lender"
  			return Lender.find(session[:user_id])
  		else
  			return Borrower.find(session[:user_id])
  		end
  	end
  	return nil
  end
  helper_method :current_user
end
