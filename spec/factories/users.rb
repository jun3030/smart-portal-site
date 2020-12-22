FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TestUser#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    sequence(:nickname) { |n| "test#{n}" }
    sequence(:address) { |n| "東京都墨田区押上1丁目1-#{n}" }
    password { "password" }
    gender { "male" }
  end
end
