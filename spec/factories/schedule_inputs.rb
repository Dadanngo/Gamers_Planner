FactoryBot.define do
  factory :schedule_input do
    event_id { nil }
    job { nil }
    comment { "MyString" }
    player_name { "MyString" }
    response { "MyText" }
    event_time_id { nil }
    token { SecureRandom.hex(10) }
    event
  end
end
