require 'rails_helper'

RSpec.describe ScheduleInput, type: :model do
  describe 'バリデーションチェック' do
    it 'tokenが空の場合、無効であること' do
      schedule_input = ScheduleInput.new(token: nil)
      expect(schedule_input).not_to be_valid
    end

    it 'tokenが一意であること' do
      existing_schedule_input = ScheduleInput.create(token: 'unique_token')
      new_schedule_input = ScheduleInput.new(token: 'unique_token')
      expect(new_schedule_input).not_to be_valid
    end

    it 'player_nameが空の場合、無効であること' do
      schedule_input = ScheduleInput.new(player_name: nil)
      expect(schedule_input).not_to be_valid
    end

    it 'player_nameが存在する場合、有効であること' do
      schedule_input = build(:schedule_input, player_name: 'Player1')
      expect(schedule_input).to be_valid
    end
  end
end
