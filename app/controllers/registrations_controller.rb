class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    customized_params = params.require(:user).permit(:name, :email, :password, :password_confirmation, :sex, :birthday)
    customized_params.merge(total_points: 0, admin: false)    # アカウント作成フォームの入力内容に、total_pointsとadminのデフォルト値を加えて登録(NOT NULL制約のため)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :sex, :birthday, :avatar, :self_introduction)
  end
end

