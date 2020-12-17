FactoryBot.define do
  factory :favorite_store do
    after(:build) do |favorite_store|
      favorite_store.user = create(:user)
      favorite_store.store = create(:store)
    end
  end
end
