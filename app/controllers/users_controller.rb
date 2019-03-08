class UsersController < ApplicationController
  before_action :check_logged_in, only: [:show]

	def show
		@user = User.find_by(id: params[:id])
    @posts = @user.posts.all
	end

  def new
  	@user = User.new
  end
  
  def create
  	@user = User.new(user_params)
  	if @user.save
      login(@user)
  		flash[:success] = "Account successfully created."
  		redirect_to @user
  	else
  		flash.now[:danger] = "Account creation failed."
  		render 'new'
  	end
  end

  private

    def check_logged_in
      if !logged_in?
        flash[:danger] = "Please log in to view user feed."
        redirect_to login_url
      end
    end

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

end
