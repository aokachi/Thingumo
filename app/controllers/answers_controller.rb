class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  
  def create
    @post = Post.find(params[:post_id])
    @answer = Answer.new(answer_params)
    @answer.post = @post
    @answer.user = current_user

    if check_answer(@answer.text)
      if @answer.save
        redirect_to @post, notice: '回答を送信しました'
      else
        flash[:alert] = "回答を送信できませんでした: " + @answer.errors.full_messages.join(', ')
        redirect_to @post
      end
    else
      flash[:alert] = "回答内容が適切ではありません"
      redirect_to @post
    end
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
  
    # ②Postsテーブルの"is_resolved"カラムに"true"の値を入れる。
    @post.update(is_resolved: true)
  
    # ③Answersテーブルの"is_selected_correct_answer"カラムに"true"の値を入れる。
    @answer.update(is_selected_correct_answer: true)
  
    # ④Postsテーブルの"resolved_user_id"カラムにUsersテーブルの対象のユーザー（選ばれたanswerをしたユーザー）のidを入れる。
    @post.update(resolved_user_id: @user.id)
  
    # ⑤"resolved_user_id"カラムに入ったidをもとに、Usersテーブルの対象のユーザーの"total_points"カラムに"10"の値を追加する。
    @user.increment!(:total_points, 10)
  
    # ⑦Answersテーブルの"points_awarded"カラムに"true"の値を入れる。
    @answer.update(points_awarded: true)
  
    # ⑧処理が終了したらモーダルにメッセージを表示する。
    render json: { message: '回答が正解として確認されました。' }
  end 

  private

  def answer_params
    params.require(:answer).permit(:text)
  end

  def check_answer(text)
    checker1 = AnswersChecker_1.new
    return true if checker1.included?(text)
  
    checker2 = AnswersChecker_2.new(text)
    return true if checker2.included?
  
    checker3 = AnswersChecker_3.new(text)
    checker3.included?
  end  
end