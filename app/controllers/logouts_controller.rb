class LogoutsController < ApplicationController
  skip_before_action :require_login
  def show
    logout
    flash[:notice] = "ログアウトしました"
    redirect_to root_path, status: :see_other
  end
end
