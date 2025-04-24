FactoryBot.define do
  factory :data_center do
    name { "mana" }
    association :game
  end
end
