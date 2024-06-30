class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :pending]
  before_action :authenticate_admin!, only: [:pending, :destroy, :approve]
  
  def create
    @post = Post.find(params[:post_id])
    @answer = Answer.new(answer_params)
    @answer.post = @post
    @answer.user = current_user

    if check_answer(@answer.text)
      if @answer.save
        redirect_to @post, notice: "回答を送信しました"
      else
        flash[:alert] = "回答を送信できませんでした: " + @answer.errors.full_messages.join(", ")
        redirect_to @post
      end
    else
      flash[:alert] = "回答内容が適切ではありません"
      redirect_to @post
    end
  end

  def confirm
    ActiveRecord::Base.transaction do
      post_id = params[:post_id]
      @post = Post.find(post_id)
      answer_id = params[:id]
      @answer = Answer.find(answer_id)
      @user = @answer.user
  
      # 処理1: postsテーブルのconfirmed_atカラムに処理を実施した日時を保存する。
      if @post.update(confirmed_at: Time.now)
        Rails.logger.info("処理実施日時の保存に成功。")
      else
        Rails.logger.error("処理実施日時の保存に失敗。")
        raise ActiveRecord::Rollback
      end
  
      # 処理2: postsテーブルのis_resolvedカラムに"true"の値を入れる。
      if @post.update(is_resolved: true)
        Rails.logger.info("is_resolvedカラムの値の変更に成功。")
      else
        Rails.logger.error("is_resolvedカラムの値の変更に失敗。")
        raise ActiveRecord::Rollback
      end
  
      # 処理3: answersテーブルのis_selected_correct_answerカラムに"true"の値を入れる。
      if @answer.update(is_selected_correct_answer: true)
        Rails.logger.info("is_selected_correct_answerカラムの値の変更に成功。")
      else
        Rails.logger.error("is_selected_correct_answerカラムの値の変更に失敗。")
        raise ActiveRecord::Rollback
      end
  
      # 処理4: postsテーブルの"resolved_user_id"カラムに、対象のユーザーのusersテーブルのidを入れる。
      if @post.update(resolved_user_id: @user.id)
        Rails.logger.info("resolved_user_idカラムの値の変更に成功。")
      else
        Rails.logger.error("resolved_user_idカラムの値の変更に失敗。")
        raise ActiveRecord::Rollback
      end
  
      # 処理5: "resolved_user_id"カラムに入ったidをもとに、対象のユーザーのusersテーブルの"total_points"カラムに"10"の値を追加する。
      if @user.increment!(:total_points, 10)
        Rails.logger.info("得点の追加に成功。")
      else
        Rails.logger.error("得点の追加に失敗。")
        raise ActiveRecord::Rollback
      end
  
      # 処理6: answersテーブルの"points_awarded"カラムに"true"の値を入れる。
      if @answer.update(points_awarded: true)
        Rails.logger.info("points_awardedカラムの値の変更に成功。")
      else
        Rails.logger.error("points_awardedカラムの値の変更に失敗。")
        raise ActiveRecord::Rollback
      end
  
      # 処理が全て成功したら、成功メッセージをクライアントに送信する。
      render json: { success: true }
    end
  rescue ActiveRecord::Rollback
    # トランザクションのロールバックが発生した場合はエラーメッセージをクライアントに送信する。
    render json: { success: false, error: "登録に失敗しました。" }, status: :unprocessable_entity
  end

  def pending
    # 保留中の回答を含む投稿を取得する
    @posts_with_pending_answers = Post.joins(:answers)
                                  .where(answers: {pending: true})
                                  .select("posts.*, MAX(answers.created_at) AS latest_answer_created_at")
                                  .group("posts.id")
                                  .order("latest_answer_created_at DESC")
                                  .page(params[:page])
    render :pending_answers
  end

  # 保留中の回答を承認するアクション
  def approve
    answer = Answer.find(params[:id])
    answer.update(pending: false)
    redirect_to post_path(answer.post), notice: "回答を承認しました。"
  end
  
  # 保留中の回答を削除するアクション
  def destroy
    answer = Answer.find(params[:id])
    if answer.destroy
      flash[:notice] = "回答を削除しました。"
      redirect_to request.referer || post_path
    else
      flash[:alert] = "削除に失敗しました。"
      redirect_to request.referer || post_path
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:text)
  end

  def authenticate_admin!
    unless current_user&.admin?
      redirect_back(fallback_location: root_path)
    end
  end

  def check_answer(text)
    checker1 = AnswersChecker_1.new
    return true if checker1.included?(text)
    
    checker2 = AnswersChecker_2.new(text, @answer)
    checker2.included?
  end  
end