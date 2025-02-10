class ProfilesController < ApplicationController
  before_action :require_login, only: [ :show ]

  def show
    @user = User.find(params[:id])
  end

private

  def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
