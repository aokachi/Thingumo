class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers
  protect_from_forgery with: :exception
  helper_method :current_user, :user_signed_in?, :admin?    # 特定のアクションを実行する前にユーザーが管理者かどうかをチェックする

  def after_sign_in_path_for(resource)
    root_path
  end

  def counts(user)
    @count_questions = user.questions.count
  end
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  private
  def admin?
    user_signed_in? && current_user.admin?
  end
end
