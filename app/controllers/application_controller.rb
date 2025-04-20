class ApplicationController < ActionController::Base
  include Sorcery::Controller
  include OauthsHelper
  before_action :require_login
  before_action :set_current_user
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def require_login
    return if current_user

    flash[:danger] = 'Googleログインが必要です'
    redirect_to root_path
  end

  private

  def set_current_user
    @user = current_user
  end

  def not_authenticated
    flash[:alert] = "ログインが必要です"
    redirect_to login_path
  end
end
