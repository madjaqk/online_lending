class BorrowersController < ApplicationController
	def create
		@borrower = Borrower.new(borrower_params)
		if @borrower.valid?
			if Lender.find_by email: @borrower.email
				flash[:errors] = ["Cannot register as both borrower and lender"]
				redirect_to "/online_lending/register"
			else 
				@borrower.raised = 0
				@borrower.save
				session[:user_id] = @borrower.id
				session[:user_type] = "borrower"
				redirect_to "/online_lending/borrower/#{@borrower.id}"
			end
		else
			flash[:errors] = @borrower.errors.full_messages
			redirect_to "/online_lending/register"
		end
	end

	def show
		@borrower = Borrower.find(params[:id])
		@loans = History.where(borrower: @borrower).joins(:lender).select("lenders.first_name, lenders.last_name, lenders.email, amount")
		render "show"
	end

	private
	def borrower_params
		params.require(:borrower).permit(:first_name, :last_name, :email, :password, :money, :purpose, :description)
	end
end

