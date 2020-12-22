FactoryBot.define do
  factory :business_trip_range do
    after(:build) do |business_trip_range|
      business_trip_range.city = create(:city)
      business_trip_range.masseur = create(:masseur)
    end
  end
end
