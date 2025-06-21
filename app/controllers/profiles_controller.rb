class ProfilesController < ApplicationController
  before_action :require_login, only: [ :show ]
  before_action :set_event, only: [ :edit, :update ]

  def show
    @user = User.find(params[:id])
    @events = Event.where(user_id: @user.id).includes(:event_times).page(params[:page]).per(10)
    @events_count = @user.events.count
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event), notice: "イベントを更新しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

private

  def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
