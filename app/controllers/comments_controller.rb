class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @commentable = find_commentable
    @comment.post = @post
    @comment.commentable = @commentable
    @comment.user = current_user

    puts "********** ここに@commentオブジェクトを表示します **********"
    puts @comment.inspect
    puts "*********************************************************"

    if @comment.save
      redirect_to @commentable, notice: 'コメントを送信しました'
    else
      flash[:alert] = "コメントを送信できませんでした: " + @comment.errors.full_messages.join(', ')
      puts "********** ここにエラーメッセージを表示します **********"
      puts @comment.errors.inspect
      puts "*********************************************************"
      redirect_to @commentable
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        commentable = $1.classify.constantize.find(value)
        puts "********** ここにcommentableオブジェクトを表示します **********"
        puts commentable.inspect
        puts "*********************************************************"
        return commentable
      end
    end
    nil
  end
end
