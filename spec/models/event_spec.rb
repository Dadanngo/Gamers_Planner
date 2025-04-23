require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'バリデーションチェック' do
    it 'イベントが1つもない場合、エラーが発生すること' do
      event = Event.new
      event.valid?
      expect(event.errors[:base]).to include("少なくとも1つの日程を追加してください。")
    end

    it 'イベントが1つ以上ある場合、エラーが発生しないこと' do
      event = Event.new
      event.event_times.build(start_time: Time.current)
      event.valid?
      expect(event.errors[:base]).not_to include("少なくとも1つの日程を追加してください。")
    end
  end
end
