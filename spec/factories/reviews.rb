FactoryBot.define do
  factory :review do
    user { nil }
    store { nil }
    content { "MyString" }
    score { 1 }
  end
end
