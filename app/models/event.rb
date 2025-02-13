class Event < ApplicationRecord
  before_create :generate_unique_url
  belongs_to :user, optional: true
  belongs_to :game, optional: true
  belongs_to :data_center, optional: true
  has_many :event_times, dependent: :destroy
  has_many :schedule_inputs, dependent: :destroy
  accepts_nested_attributes_for :event_times

  private

  def generate_unique_url
    # 生成重複防ぐ
    loop do
      self.url = SecureRandom.hex(10)
      break unless Event.exists?(url: self.url)
    end
  end
end
