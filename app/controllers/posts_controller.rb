class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def show
    @question = Question.find(params[:id])
    @questions = Question.where(user_id: @question.user.id) # 質問詳細ページの関連質問の欄用
    @answers = @question.answers.page(params[:page]).per(10).reverse_order
    @answer = @question.answers.build # 質問全体への回答質問用の変数
    @answer_reply = @question.answers.build # 回答に対する返信用の変数
    if current_user != @question.user
      @question.increment!(:view_count)
    end
  end

  def new
    @categories = Category.all
    @question = current_user.questions.build # 質問フォームのform_with用
    # @question.question_images.build
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = '送信しました'
      redirect_to root_url    
    else
      @questions = current_user.questions.order(id: :desc).page(params[:page])
      flash.now[:danger] = '送信できませんでした'
      render 'questions/new'
    end
  end
    
  def destroy
    @question = current_user.questions.find(params[:id])
    @question.destroy
    flash[:success] = 'メッセージを削除しました'
    redirect_back(fallback_location: root_path)
  end

  private

  def question_params
    params.require(:question).permit(:title, :text, :category_id, { images: [] })
  end
end
