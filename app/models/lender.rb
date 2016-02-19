class Lender < ActiveRecord::Base
	has_secure_password
	has_many :histories
	has_many :lent_to, through: :histories, source: :borrower

	validates :first_name, :last_name, :money, presence: true
	validates :email, presence: true, uniqueness: { case_sensitive: false }
end
