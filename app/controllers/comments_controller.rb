class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        #非同期の場合
        #format.js { render :index }
        flash[:success] = '送信しました'
        redirect_to post_path(@comment.post)
      else
        flash.now[:danger] = '送信できませんでした'
        render 'posts/show'
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comments, :user_id, :post_id, :parent_id)
  end
end
