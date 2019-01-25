module SessionsHelper

	def login(user)
		session[:user_id] = user.id
	end

	def remember(user)
		user.assignRememberTokenAndStoreDigest
		cookies.permanent.signed[:user_id] = session[:user_id]
		cookies.permanent[:remember_token] = user.remember_token
	end

end
