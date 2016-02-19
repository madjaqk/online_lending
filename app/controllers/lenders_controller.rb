class LendersController < ApplicationController
	def create
		@lender = Lender.new(lender_params)
		if @lender.valid?
			if Borrower.find_by email: @lender.email
				flash[:errors] = ["Cannot register as both borrower and lender"]
				redirect_to "/online_lending/register"
			else 
				@lender.save
				session[:user_id] = @lender.id
				session[:user_type] = "lender"
				redirect_to "/online_lending/lender/#{@lender.id}"
			end
		else
			flash[:errors] = @lender.errors.full_messages
			redirect_to "/online_lending/register"
		end
	end

	def show
		@lender = Lender.find(params[:id])
		@can_lend = true if @lender == current_user and @lender.money > 0
		@borrowers = Borrower.where("money > raised").order(created_at: :desc) # Only find borrowers who haven't met their goal
		@loans = History.where(lender: @lender).joins(:borrower).select("borrowers.first_name, borrowers.last_name, borrowers.purpose, borrowers.description, borrowers.money, borrowers.raised, amount")
	end

	private
	def lender_params
		params.require(:lender).permit(:first_name, :last_name, :email, :password, :money)
	end
end
