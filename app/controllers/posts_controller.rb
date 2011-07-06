class PostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  
  def create
    @post  = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end

  def destroy
  end
end
