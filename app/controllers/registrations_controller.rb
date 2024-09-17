class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user! 
  before_action :configure_account_update_params, only: [:update]

  def update
    @user = User.find(current_user.id)

    # パスワードが空の場合はそれ以外を更新
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    # ニックネームが空の場合はそれ以外を更新
    # 職業が空の場合はそれ以外を更新
    # アバター画像ファイルが変更ない場合はそれ以外を更新

    if @user.update(account_update_params)
      bypass_sign_in(@user)
      redirect_to after_update_path_for(@user), notice: 'ユーザー情報は正常に変更されました。'
    else
      render "edit"
    end
  end

  def update_avatar
    if current_user.update(avatar: params[:avatar])
      render json: { avatar_url: url_for(current_user.avatar.variant(resize: "115x115"))}
    else
      render json: { error: "アバター画像の更新に失敗しました。"}, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    customized_params = params.require(:user).permit(:name, :email, :password, :password_confirmation, :sex, :birthday)
    customized_params.merge(total_points: 0, admin: false)    # アカウント作成フォームの入力内容に、total_pointsとadminのデフォルト値を加えて登録(NOT NULL制約のため)
  end

  def resize_avatar(avatar)
    image = MiniMagick::Image.read(avatar.download)
    image.resize "115x115"
    avatar.attach(io: StringIO.new(image.to_blob), filename: avatar.filename, content_type: avatar.content_type)
  end

  protected

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :region, :avatar])
  end
end

