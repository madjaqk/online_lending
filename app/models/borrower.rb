class Borrower < ActiveRecord::Base
	has_secure_password
	has_many :histories
	has_many :borrowed_from, through: :histories, source: :lender

	validates :first_name, :last_name, :money, presence: true
	validates :email, presence: true, uniqueness: { case_sensitive: false }
end
