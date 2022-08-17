class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]

  def show
    @user = User.find_by(id: params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'アカウントを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'アカウントを登録できませんでした。'
      render :root
    end
  end


  private


  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
