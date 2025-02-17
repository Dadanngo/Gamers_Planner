class EventTime < ApplicationRecord
  belongs_to :event
  has_many :event_times
end
