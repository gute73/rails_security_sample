class User < ApplicationRecord
	attr_accessor :remember_token

	before_save :emailToLowercase

	validates :name, presence: true, length: { maximum: 50 }
	  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 8 }

	def emailToLowercase
		email.downcase!
	end

	def self.generateToken
		SecureRandom.urlsafe_base64
	end

  def self.generateDigest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

	def assignRememberTokenAndStoreDigest
		self.remember_token = User.generateToken
		update_attribute(:remember_digest, User.generateDigest(remember_token))
	end

end
