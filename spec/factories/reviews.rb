FactoryBot.define do
  factory :review do
    content { "MyContent" }
    rate { 1 }
    title { "Mytitle" }

    after(:build) do |review|
      review.user = create(:user)
      review.store = create(:store)
    end
  end
end
