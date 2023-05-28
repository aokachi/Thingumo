class ToppagesController < ApplicationController
  def index
    @categories = Category.all
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @posts = @category.posts.order(created_at: :desc).all.page(params[:page]).per(15)
    else
      @posts = Post.order(created_at: :desc).all.page(params[:page]).per(15)
    end
  end
end
