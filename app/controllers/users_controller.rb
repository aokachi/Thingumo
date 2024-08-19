class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    @answers = @user.answers.includes(:question) # ユーザーが回答した質問の一覧
  end

  def update_avatar
    @user = User.find(params[:id])
    if @user.update(avatar_params)
      resize_avatar(@user.avatar)
      redirect_to profile_path, notice: 'アバター画像を更新しました。'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :sex, :birthday, :avatar)
  end

  def avatar_params
    params.require(:user).permit(:avatar)
  end

  def resize_avatar(avatar)
    image = MiniMagick::Image.read(avatar.download)
    image.resize "115x115"
    avatar.attach(io: StringIO.new(image.to_blob), filename: avatar.filename, content_type: avatar.content_type)
end
