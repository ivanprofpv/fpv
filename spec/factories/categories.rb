FactoryBot.define do
  factory :category do
    title { "DroneCategory" }

    trait :invalid do
      title { nil }
    end
  end
end
