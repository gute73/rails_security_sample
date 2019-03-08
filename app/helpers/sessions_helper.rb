module SessionsHelper

	def login(user)
		session[:user_id] = user.id
	end

	def remember(user)
		user.assign_remember_token_and_digest
		cookies.permanent.signed[:user_id] = session[:user_id]
		cookies.permanent[:remember_token] = user.remember_token
	end

	def forget(user)
		user.delete_remember_digest
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	def current_user
		if session[:user_id]
			@current_user ||= User.find_by(id: session[:user_id])
		elsif cookies.signed[:user_id]
			user = User.find_by(id: cookies.signed[:user_id])
  			if user && user.authenticated?(cookies[:remember_token])
  				login(user)
  				@current_user = user
  			end
		end
	end

	def current_user?(user)
		user == current_user
	end

	def logged_in?
		!current_user.nil?
	end

	def logout
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

end
