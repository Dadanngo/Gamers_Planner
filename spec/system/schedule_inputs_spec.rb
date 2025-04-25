require 'rails_helper'

RSpec.describe "ScheduleInputs", type: :system do
  before do
    @event = build(:event)
    @event.event_times.build(start_time: "2025-10-01 20:00")
    @event.save!
  end

  describe "予定入力" do
    it "参加者が予定入力フォームを参照できる", js: true do
      # イベント共有URLへアクセス（例: /events/:url/token）
      visit "/events/url/#{@event.url}/schedule_inputs"
      click_on "プレイヤー予定追加"
      expect(page).to have_content "日程登録"
    end

    it "予定入力ができる", js: true do
      visit "/events/url/#{@event.url}/schedule_inputs"
      click_on "プレイヤー予定追加"
      fill_in "プレイヤー名", with: "Test Player"
      select "ヒーラー", from: "ジョブor武器(候補にない場合は未入力)"
      within("div#response_ok_#{@event.event_times.first.id}") rescue nil
      choose("response_ok_#{@event.event_times.first.id}", allow_label_click: true)
      click_on "登録"
      expect(page).to have_content "登録完了しました"
    end
  end
end
