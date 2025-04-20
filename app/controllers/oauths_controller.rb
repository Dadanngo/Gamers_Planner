class OauthsController < ApplicationController
  include OauthsHelper
  skip_before_action :require_login
  skip_before_action :verify_authenticity_token


  def oauth
    redirect_to "/auth/google_oauth2", allow_other_host: true
  end

  def callback
    user = find_or_create_from_auth_hash(auth_hash)
    log_in(user)
    Rails.logger.info "ログイン完了: user_id=#{user.id}, session[:user_id]=#{session[:user_id]}"
    redirect_to root_path, notice: "Googleログインに成功しました"
  end

  def destroy
    log_out
    redirect_to root_path, notice: "ログアウトしました"
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def find_or_create_from_auth_hash(auth_hash)
    email = auth_hash['info']['email']
    name  = auth_hash['info']['name']

    user = User.find_or_initialize_by(email: email)
    user.name ||= name

    if user.new_record?
      random_password = SecureRandom.urlsafe_base64(12)
      user.password = random_password
      user.password_confirmation = random_password
    end

    user.save!
    user
  end
end
