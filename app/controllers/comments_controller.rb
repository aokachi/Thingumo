class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = post.id
    # 入力されたコメントでWikipediaを検索し、一致するものがあるか確認する
    @word = Wikipedia.find(params[:post_id])
    @word_result = @word.title
    # @word_resultがnilでなければコメントを送信する
    # nillだったらコメントを送信しない
    unless @word_result.nil?
      @comment.save
    end
    redirect_to post_path(post)
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :post_id, :user_id, :parent_comment_id)
  end

end
