FactoryBot.define do
  factory :prefecture do
    sequence(:name) { |n| "name#{n}" }

    after(:build) do |prefecture|
      prefecture.region = create(:region)
    end
  end
end
