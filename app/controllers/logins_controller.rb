class LoginsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :verify_authenticity_token, only: [ :create ]

  def new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      Rails.logger.info "ログイン成功: #{@user.email}"
      redirect_to root_path, notice: 'ログインしました'
    else
      Rails.logger.info "ログイン失敗: raw_params=#{params.inspect}"
      flash.now[:alert] = 'ログインできませんでした'
      render :new, status: :unprocessable_entity
    end
  end
end
