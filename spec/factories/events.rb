FactoryBot.define do
  factory :event do
    name { "MyString" }
    hunter_id { "MyString" }
    lobby_id { "MyString" }
    url { "MyString" }
    user_id { nil }
    data_center_id { nil }
    game_id { nil }
  end
end
