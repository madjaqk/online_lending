class HistoriesController < ApplicationController
	def create
		if !current_user
			flash[:errors] = ["Must be logged in to loan money"]
			redirect_to "/online_lending/login"
		elsif session[:user_type] == "borrower"
			flash[:errors] = ["Borrowers can't loan money"]
			redirect_to "/online_lending/borrower/#{session[:user_id]}"
		else
			@lender = current_user
			@borrower = Borrower.find(params[:borrower_id])
			@amount = params[:amount].to_i
			if @amount < 0
				flash[:errors] = ["You have no more money to give"]
				redirect_to "/online_lending/lender/#{@lender.id}"
			elsif @amount > @lender.money
				flash[:errors] = ["Insufficient funds"]
				redirect_to "/online_lending/lender/#{@lender.id}"
			else
				History.create(lender: @lender, borrower: @borrower, amount: @amount)
				@lender.money -= @amount
				@lender.save

				@borrower.raised += @amount
				@borrower.save
				redirect_to "/online_lending/lender/#{@lender.id}"
			end
		end
	end
end
