class LogoutsController < ApplicationController
  def show
    logout
    flash[:notice] = "ログアウトしました"
    redirect_to root_path, status: :see_other
  end
end
