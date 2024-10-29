class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!
  before_action :configure_sign_up_params, only:[:create]
  before_action :configure_account_update_params, only: [:update]

  def update
    @user = current_user

    # パラメータを取得
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    # 更新処理
    if update_resource(@user, account_update_params)

      # パスワード変更後もログイン状態を維持
      bypass_sign_in(@user)

      # 成功時のリダイレクト
      respond_to do |format|
        format.html { redirect_to user_path(@user), notice: 'アカウントが更新されました。' }
        format.js   { render js: "window.location.href='#{user_path(@user)}';" }
      end
    else
      # 失敗時のエラーメッセージをカスタムメッセージにマッピング
      @custom_errors = map_errors(@user.errors)
        Rails.logger.debug "ユーザーのエラー: #{@user.errors.full_messages.inspect}"
        Rails.logger.debug "カスタムエラー: #{@custom_errors.inspect}"

      respond_to do |format|
        format.html { redirect_to edit_user_registration_path, alert: 'アカウントの更新に失敗しました。' }
        format.js   { render 'update_error', content_type: 'text/javascript' }
      end
    end
    # super
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
      if params[:password].present?
        # パスワードを更新
        password_params = params.slice(:password, :password_confirmation, :current_password)
        success = resource.update_with_password(password_params)
  
        # 他の属性を更新
        other_params = params.except(:current_password, :password, :password_confirmation)
        if other_params.present? && success
          resource.assign_attributes(other_params)
          success &= resource.save
        end
      else
        # パスワードなしで他の属性を更新
        other_params = params.except(:current_password, :password, :password_confirmation)
        success = resource.update_without_password(other_params)
      end
    rescue ActiveRecord::RecordInvalid
      success = false
    end
  
    success
  end

  # バリデーションエラーをカスタムメッセージにマッピング
  def map_errors(errors)
    custom_messages = []
    Rails.logger.debug "エラーの詳細: #{errors.details.inspect}"
    errors.details.each do |attribute, details|
      details.each do |error_detail|
        error_type = error_detail[:error]
        case [attribute.to_sym, error_type]
        when [:name, :blank]
          custom_messages << 'ニックネームを入力してください。'
        when [:name, :too_long]
          custom_messages << 'ニックネームが長すぎます。'
        when [:current_password, :blank], [:current_password, :invalid]
          custom_messages << '現在のパスワードが正しくありません。'
        when [:password, :blank]
          custom_messages << '新しいパスワードを入力してください。'
        when [:password, :too_short]
          custom_messages << '新しいパスワードが短すぎます。半角6文字以上で入力してください。'
        when [:password_confirmation, :confirmation]
          custom_messages << '入力された新しいパスワードと確認用のパスワードが一致しません。再度入力してください。'
        else
          if error_detail[:message].present?
            custom_messages << errors.full_message(attribute, error_detail[:message])
          else
            custom_messages << errors.full_message(attribute, error_type.to_s)
          end
        end
      end
    end
    custom_messages.uniq
  end

  protected

  # 更新に成功したら/users/showに遷移する
  def after_update_path_for(resource)
    user_path(resource)
  end
end