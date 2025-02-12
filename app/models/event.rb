class Event < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :game
  belongs_to :data_center
  has_many :event_times, dependent: :destroy
  accepts_nested_attributes_for :event_times
end
