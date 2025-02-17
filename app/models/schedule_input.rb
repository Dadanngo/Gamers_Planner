class ScheduleInput < ApplicationRecord
  belongs_to :event
  belongs_to :event_time, optional: true
  validates :token, presence: true, uniqueness: true
end
