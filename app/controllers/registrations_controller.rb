class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!
  before_action :configure_sign_up_params, only:[:create]
  before_action :configure_account_update_params, only: [:update]

  def update
    @user = current_user

    super
  end

  private

  # アカウント作成時の許可パラメータ
  def sign_up_params
    customized_params = params.require(:user).permit(:name, :email, :password, :password_confirmation, :sex, :birthday).merge(total_points: 0, admin: false)
  end

  # ユーザ情報更新時の許可パラメータ
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :region, :avatar, :current_password, :password, :password_confirmation])
  end

  protected

  def update_resource(resource, params)
    success = true
    begin
      ActiveRecord::Base.transaction do
        if params[:password].present?
          # パスワードを更新
          password_params = params.slice(:password, :password_confirmation, :current_password)
          success = resource.update_with_password(password_params)

          # 他の属性を更新
          other_params = params.except(:current_password, :password, :password_confirmation)
          success &= resource.update(other_params) if other_params.present?
        else
          other_params = params.except(:current_password, :password, :password_confirmation)
          success = resource.update_without_password(other_params)
        end

        raise ActiveRecord::Rollback unless success
      end
    rescue ActiveRecord::RecordInvalid
      success = false
    end

    success
  end

  protected

  # 更新に成功したら/users/showに遷移する
  def after_update_path_for(resource)
    user_path(resource)
  end
end