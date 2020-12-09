FactoryBot.define do
  factory :message do
    sequence(:title) { |n| "title#{n}" }
    sequence(:content) { |n| "content"*10 }
    sequence(:checked) { |n| "checked" }
    association :user
    association :store
  end
end
