class Event < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :game,optional:true
  belongs_to :data_center,optional: true
  has_many :event_times, dependent: :destroy
  accepts_nested_attributes_for :event_times
end
