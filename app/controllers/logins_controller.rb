class LoginsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate_password(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "ログインしました"
      redirect_to users_path
    else
      flash.now[:warning] = 'ログインできませんでした'
      render :new, status: :unprocessable_entity
    end
  end
end
