class SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate(auth_options)
    if resource && resource.active_for_authentication?
      sign_in(resource_name, resource)
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      flash.keep[:alert] = 'メールアドレスまたはパスワードが正しくありません。'
      redirect_to root_url
    end
  end
end
