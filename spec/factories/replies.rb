FactoryBot.define do
  factory :reply do
    reply { "MyString" }
    store { nil }
    user { nil }
    message { nil }
  end
end
