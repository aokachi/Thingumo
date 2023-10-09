class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  
  def create
    @post = Post.find(params[:post_id])
    @answer = Answer.new(answer_params)
    @answer.post = @post
    @answer.user = current_user

    if @answer.save
      redirect_to @post, notice: 'コメントを送信しました'
    else
      flash[:alert] = "コメントを送信できませんでした: " + @answer.errors.full_messages.join(', ')
      puts "********** ここにエラーメッセージを表示します **********"
      puts @answer.errors.inspect
      puts "*********************************************************"
      redirect_to @post
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:text)
  end

  def confirm
    # どの質問か
    post_id = params[:post_id]
    @post = Post.find(post_id)
  
    # どの回答(answer)か
    answer_id = params[:answer_id]
    @answer = Answer.find(answer_id)
  
    # 当該回答をしたユーザーは誰か
    @user = @answer.user
  
    # ①"confirm-answer-btn"を押した日時のタイムスタンプを保存する。
    @post.update(confirmed_at: Time.now)
  
    # ②Postsテーブルの"is_resolved"カラムに"1"の値を入れる。
    @post.update(is_resolved: 1)
  
    # ③Answersテーブルの"is_selected_correct_answer"カラムに"1"の値を入れる。
    @answer.update(is_selected_correct_answer: 1)
  
    # ④Postsテーブルの"resolved_user_id"カラムにUsersテーブルの対象のユーザー（選ばれたanswerをしたユーザー）のidを入れる。
    @post.update(resolved_user_id: @user.id)
  
    # ⑤"resolved_user_id"カラムに入ったidをもとに、Usersテーブルの対象のユーザーの"total_points"カラムに"10"の値を追加する。
    @user.increment!(:total_points, 10)
  
    # ⑦Answersテーブルの"points_awarded"カラムに"1"の値を入れる。
    @answer.update(points_awarded: 1)
  end  
end
