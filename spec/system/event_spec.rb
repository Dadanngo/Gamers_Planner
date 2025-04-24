RSpec.describe "Events", type: :system do
  describe "予定を立てる" do
      let!(:game) { create(:game, title: "FF14") }
      let!(:data_center) { create(:data_center, name: "mana", game: game) }

    it "予定を立てることができる", js: true do
      event = Event.create!(
        name: "test_event",
        game: game,
        data_center: data_center,
        event_times_attributes: [
          { start_time: Time.zone.parse("2023-10-01 10:00") }
        ]
      )
      expect(event.name).to eq "test_event"
    end

    it "日付未入力だと予定を立てることができない", js: true do
      event = Event.create(
        name: "test_event",
        game: nil,
        data_center: nil,
      )
      expect(event).not_to be_valid
    end
  end
end
