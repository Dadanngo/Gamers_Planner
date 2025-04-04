class ApplicationController < ActionController::Base
  include Sorcery::Controller
  before_action :set_current_user
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def set_current_user
    @user = current_user
  end

  def not_authenticated
    flash[:alert] = "ログインが必要です"
    redirect_to login_path
  end
end
