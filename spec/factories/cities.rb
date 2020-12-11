FactoryBot.define do
  factory :city do
    sequence(:name) { |n| "city#{n}" }

    after(:build) do |city|
      city.prefecture = create(:prefecture)
    end
  end
end
