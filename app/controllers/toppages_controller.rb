class ToppagesController < ApplicationController
  def index
    @categories = Category.all
    @selected_category_id = params[:category_id]

    if @selected_category_id
      @category = Category.find(@selected_category_id)
      @questions = @category.questions.order(created_at: :desc).page(params[:page]).per(15)
    else
      @questions = Question.order(created_at: :desc).page(params[:page]).per(15)
    end
  end
end