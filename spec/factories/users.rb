FactoryBot.define do
  factory :user do
    name { "dada" }
    sequence(:email) { |n| "dadatest_#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }

    trait :activated do
      after(:create) do |user|
        user.activate!
      end
    end
  end
end
