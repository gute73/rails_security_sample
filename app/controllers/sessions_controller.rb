class SessionsController < ApplicationController

  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		login(user)
  		remember(user)
  		flash[:success] = "Welcome back, #{user.name}!"
  		redirect_to user
  	else
  		flash.now[:danger] = "Incorrect email/password combination"
  		render 'new'
  	end
  end

  def destroy
  end

end

