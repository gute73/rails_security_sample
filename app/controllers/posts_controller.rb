class PostsController < ApplicationController
	  before_action :check_logged_in, only: [:new, :create]

  def new
  	@post = current_user.posts.new
  end

  def create
  	@post = current_user.posts.build(post_params)
  	if @post.save
  		flash[:success] = "Post successful!"
  		redirect_to posts_url
  	else
  		flash.now[:danger] = "Post failed."
  		render 'new'
  	end
  end

  def index
  	@posts = Post.all
  end

	private

  	def check_logged_in
  		if !logged_in?
  			flash[:danger] = "Please log in to create a post."
  			redirect_to login_url
  		end
  	end

  	private

  	def post_params
  		params.require(:post).permit(:content)
  	end

end
