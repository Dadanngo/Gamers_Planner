class LoginsController < ApplicationController
  def new
  end

  def create
    @user = login(params[:email], params[:password])
      if @user
        flash[:notice] = "ログインしました"
        redirect_to profile_path(@user)
      else
        flash.now[:warning] = "ログインできませんでした"
        render :new, status: :unprocessable_entity
      end
  end
end
