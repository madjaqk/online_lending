class SessionsController < ApplicationController
  def login
  	render "login"
  end

  def register
  	puts "******"
  	puts session[:user_id], session[:user_type]
  	puts "******"
  	@lender = Lender.new
  	@borrower = Borrower.new
  	render "register"
  end

  def new
  	user = Borrower.find_by email: params[:email]
  	if user
  		if user.authenticate(params[:password])
  			session[:user_id] = user.id
  			session[:user_type] = "borrower"
  			redirect_to "/online_lending/borrower/#{user.id}"
  		else
  			flash[:errors] = ["Incorrect password"]
  			redirect_to "/online_lending/login"
  		end
  	else
  		user = Lender.find_by email: params[:email]
  		if user
  			if user.authenticate(params[:password])
  				session[:user_id] = user.id
  				session[:user_type] = "lender"
  				redirect_to "/online_lending/lender/#{user.id}"
  			else
  				flash[:errors] = ["Incorrect password"]
  				redirect_to "/online_lending/login"
  			end
  		else
  			flash[:errors] = ["E-mail address not found"]
  			redirect_to "/online_lending/login"
  		end
  	end
  end

  def logout
  	session[:user_id] = nil
  	session[:user_type] = nil
  	redirect_to "/online_lending/register"
  end
end
