class User < ApplicationRecord
	attr_accessor :remember_token
	has_many :posts

	before_save :email_to_lowercase

	validates :name, presence: true, length: { maximum: 50 }
	  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 8 }

	def email_to_lowercase
		email.downcase!
	end

	def self.generate_token
		SecureRandom.urlsafe_base64
	end

  def self.generate_digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

	def assign_remember_token_and_digest
		self.remember_token = User.generate_token
		update_attribute(:remember_digest, User.generate_digest(remember_token))
	end

	def delete_remember_digest
		update_attribute(:remember_digest, nil)
	end

	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

end
