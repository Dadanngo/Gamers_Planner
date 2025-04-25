FactoryBot.define do
  factory :event_time do
    start_time { Time.zone.parse("2025-01-01 10:00") }
    association :event
  end
end
