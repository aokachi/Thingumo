class CategoriesController < ApplicationController

  def index
   @posts = Post.where(category_id: params[:category_id]).page(params[:page]).per(15).search(params[:search])
   @categories = Category.all
  end
end
