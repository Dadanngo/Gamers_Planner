class NotificationsController < ApplicationController
  before_action :require_login

  def create
    event = Event.find_by(id: params[:event_id])
    setting = Notification.find_or_initialize_by(user: current_user, event_id: params[:event_id])
    setting.notify_today = true
    setting.notify_daily = true
    setting.save!

    redirect_to event_schedule_inputs_by_url_path(url: event.url), notice: "Discord連携完了！毎日17時に予定の有無を通知します。"
  end
end
