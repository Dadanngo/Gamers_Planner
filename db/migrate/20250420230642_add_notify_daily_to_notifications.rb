class AddNotifyDailyToNotifications < ActiveRecord::Migration[7.2]
  def change
    add_column :notifications, :notify_daily, :boolean
  end
end
