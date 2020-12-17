FactoryBot.define do
  factory :plan do
    sequence(:plan_name) { |n| "plan_name#{n}" }
    sequence(:plan_content) { |n| "plan_content#{n}" }
    sequence(:plan_time){ |n| "1#{n}" }
    sequence(:plan_price){ |n| "2#{n}" }

    after(:build) do |plan|
      plan.store = create(:store)
    end
  end
end