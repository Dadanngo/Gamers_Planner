FactoryBot.define do
  factory :user do
    name { "dada" }
    sequence(:email) { |n| "dadatest_#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    activation_state { true }
    activation_token_expires_at { Time.current }
    reset_password_token { nil }
    reset_password_email_sent_at { nil }
  end
end
