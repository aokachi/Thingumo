class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    @answers = @user.answers.includes(:question) # ユーザーが回答した質問の一覧
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :sex, :birthday)
  end
end
