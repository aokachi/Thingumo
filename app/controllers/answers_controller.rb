class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  
  def create
    @post = Post.find(params[:post_id])
    @answer = Answer.new(answer_params)
    @answerable = find_answerable
    @answer.post = @post
    @answer.answerable = @answerable
    @answer.user = current_user

    if @answer.save
      redirect_to @answerable, notice: 'コメントを送信しました'
    else
      flash[:alert] = "コメントを送信できませんでした: " + @answer.errors.full_messages.join(', ')
      puts "********** ここにエラーメッセージを表示します **********"
      puts @answer.errors.inspect
      puts "*********************************************************"
      redirect_to @answerable
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end

  def find_answerable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        answerable = $1.classify.constantize.find(value)
        return answerable
      end
    end
    nil
  end
end
