class ScheduleInput < ApplicationRecord
  belongs_to :event
  validates :token, presence: true, uniqueness: true
end
