class ToppagesController < ApplicationController
  def index
    @categories = Category.all
    if params[:category_id]
      @posts = posts.where(category_id: params[:category_id]).order(created_at: :desc).page(params[:page]).per(15) #該当カテゴリの投稿を表示
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page]).per(15) #全投稿の表示
    end
  end
end
