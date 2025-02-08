class LogoutsController < ApplicationController
  def show
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to root_path, status: :see_other
  end
end
