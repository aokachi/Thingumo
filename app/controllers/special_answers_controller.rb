class SpecialAnswersController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @special_answer = SpecialAnswer.new
  end

  def create
    @special_answer = SpecialAnswer.new(special_answer_params)
    existing_answer = SpecialAnswer.find_by(content: @special_answer.content)
    if existing_answer
      @special_answer.approval = existing_answer.approval
    end
    if @special_answer.save
      redirect_to post_path(@special_answer.post)
    else
      render :new
    end
  end

  private

  def special_answer_params
    params.require(:special_answer).permit(:content, :user_id, :post_id)
  end
end
