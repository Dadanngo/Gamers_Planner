class ScheduleInput < ApplicationRecord
  belongs_to :event
  belongs_to :event_time, optional: true
  validates :token, presence: true, uniqueness: true
  validates :player_name, presence: { message: "プレイヤー名を入力してください" }
end
