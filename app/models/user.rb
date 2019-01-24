class User < ApplicationRecord
	validates :name, presence: true, length: { maximum: 50 }
	  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	before_save :emailToLowercase
	has_secure_password
	validates :password, presence: true, length: { minimum: 8 }

	def emailToLowercase
		email.downcase!
	end

end